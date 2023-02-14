//
//  EpisodeApi.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 8/2/23.
//

import Foundation
class EpisodesApi: EpisodesProtocol {
    
    func fetchEpisodesById(episodesIds: [Int], completionHandler: @escaping FetchEpisodesCompletionHandler) {
        let episodesString = episodesIds.map{String($0)}.joined(separator: ",")
        let urlString = "\(BASE_URL)episode/\(episodesString)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let episodes = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: episodes))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
    
    func fetchEpisode(episodeId: Int, completionHandler: @escaping FetchEpisodeCompletionHandler) {
        let urlString = "\(BASE_URL)episode/\(episodeId)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: episode))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
    
    func fetchEpisodesFirstPage(completionHandler: @escaping FetchEpisodesPageCompletionHandler) {
        let urlString = "\(BASE_URL)episode"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let episodesPageApiResponse = try JSONDecoder().decode(EpisodesPageApiResponse.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: episodesPageApiResponse))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
    
    func fetchEpisodesNextPage(urlString: String, completionHandler: @escaping FetchEpisodesPageCompletionHandler) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let episodesPageApiResponse = try JSONDecoder().decode(EpisodesPageApiResponse.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: episodesPageApiResponse))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
}
