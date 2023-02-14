//
//  LocationsProtocol.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 10/2/23.
//

import Foundation
// MARK: - Rick and Morti characters API

protocol LocationsProtocol
{
    func fetchLocationsById(locationIds: [Int], completionHandler: @escaping FetchLocationsCompletionHandler)
    func fetchLocation(locationId: Int, completionHandler: @escaping FetchLocationCompletionHandler)
    func fetchLocationsFirstPage(completionHandler: @escaping FetchLocationsPageCompletionHandler)
    func fetchLocationsNextPage(urlString: String, completionHandler: @escaping FetchLocationsPageCompletionHandler)
}

// MARK: - App CRUD operation results

typealias FetchLocationsCompletionHandler = (ServiceOperationResult<[Location]>) -> Void
typealias FetchLocationCompletionHandler = (ServiceOperationResult<Location>) -> Void
typealias FetchLocationsPageCompletionHandler = (ServiceOperationResult<LocationsPageApiResponse>) -> Void

struct LocationsPageApiResponse: Codable {
    var info: PaginationInfo
    var results: [Location]
}
