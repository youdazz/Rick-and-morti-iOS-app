//
//  LocationsApi.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 10/2/23.
//

import Foundation
class LocationsApi: LocationsProtocol {
    
    func fetchLocationsById(locationIds: [Int], completionHandler: @escaping FetchLocationsCompletionHandler) {
        let locationsString = locationIds.map{String($0)}.joined(separator: ",")
        let urlString = "\(BASE_URL)location/\(locationsString)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let locations = try JSONDecoder().decode([Location].self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: locations))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
    
    func fetchLocation(locationId: Int, completionHandler: @escaping FetchLocationCompletionHandler) {
        let urlString = "\(BASE_URL)location/\(locationId)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let location = try JSONDecoder().decode(Location.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: location))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
    
    func fetchLocationsFirstPage(completionHandler: @escaping FetchLocationsPageCompletionHandler) {
        let urlString = "\(BASE_URL)location"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let locationsPageApiResponse = try JSONDecoder().decode(LocationsPageApiResponse.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: locationsPageApiResponse))
                } catch {
                    completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
                }
            } else if error != nil {
                completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
            }
        }

        task.resume()
    }
    
    func fetchLocationsNextPage(urlString: String, completionHandler: @escaping FetchLocationsPageCompletionHandler) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do{
                    let locationsPageApiResponse = try JSONDecoder().decode(LocationsPageApiResponse.self, from: data)
                    completionHandler(ServiceOperationResult.Success(result: locationsPageApiResponse))
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
