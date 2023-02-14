//
//  CharactersApi.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
struct CharactersApi: CharactersProtocol {
    func fetchCharactersWithFilter(filter: SearchCharacterFilter, completionHandler: @escaping FetchCharactersWithFilterCompletionHandler) {
        
        let urlString = BASE_URL + "character"
        var url = URL(string: urlString)!
        
        let queryItems = getQueryItemsFromFilter(filter: filter)
        url.append(queryItems: queryItems)

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    print(String(data: data, encoding: .utf8))
                    let response = try JSONDecoder().decode(CharactersApiResponse.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: response))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }
        task.resume()
    }
    
    func getQueryItemsFromFilter(filter: SearchCharacterFilter) -> [URLQueryItem]{
        var queryItems = [URLQueryItem]()
        if !(filter.name?.isEmpty ?? true) {
            queryItems.append(URLQueryItem(name: "name", value: filter.name))
        }
        if !(filter.status?.isEmpty ?? true) {
            queryItems.append(URLQueryItem(name: "status", value: filter.status))
        }
        if !(filter.specie?.isEmpty ?? true) {
            queryItems.append(URLQueryItem(name: "species", value: filter.specie))
        }
        if !(filter.gender?.isEmpty ?? true) {
            queryItems.append(URLQueryItem(name: "gender", value: filter.gender))
        }
        if !(filter.type?.isEmpty ?? true) {
            queryItems.append(URLQueryItem(name: "type", value: filter.type))
        }
        return queryItems
    }
    
    func fetchCharacters(completionHandler: @escaping FetchCharactersCompletionHandler) {
        
        let urlString = BASE_URL + "character"
        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let response = try JSONDecoder().decode(CharactersApiResponse.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: response))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
    
    func fetchNextPage(urlString: String, completionHandler: @escaping FetchCharactersCompletionHandler) {
        
        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let response = try JSONDecoder().decode(CharactersApiResponse.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: response))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
    
    func fetchCharacter(id: String, completionHandler: @escaping FetchCharacterCompletionHandler) {
        
    }
    
    
    func createCharacters(characters: [Character], completionHandler: @escaping CreateCharacterCompletionHandler) {
        
    }
    
    func deleteCharacters(completionHandler: @escaping DeleteCharacterCompletionHandler) {
        
    }
}
