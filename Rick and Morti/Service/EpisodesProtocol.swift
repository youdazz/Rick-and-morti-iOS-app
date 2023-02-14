//
//  EpisodeProtocol.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 8/2/23.
//

import Foundation
// MARK: - Rick and Morti characters API

protocol EpisodesProtocol
{
    func fetchEpisodesById(episodesIds: [Int], completionHandler: @escaping FetchEpisodesCompletionHandler)
    func fetchEpisode(episodeId: Int, completionHandler: @escaping FetchEpisodeCompletionHandler)
    func fetchEpisodesFirstPage(completionHandler: @escaping FetchEpisodesPageCompletionHandler)
    func fetchEpisodesNextPage(urlString: String, completionHandler: @escaping FetchEpisodesPageCompletionHandler)
}

// MARK: - App CRUD operation results

typealias FetchEpisodesCompletionHandler = (ServiceOperationResult<[Episode]>) -> Void
typealias FetchEpisodeCompletionHandler = (ServiceOperationResult<Episode>) -> Void
typealias FetchEpisodesPageCompletionHandler = (ServiceOperationResult<EpisodesPageApiResponse>) -> Void

struct EpisodesPageApiResponse: Codable {
    var info: PaginationInfo
    var results: [Episode]
}
