//
//  CharacterDetailInteractor.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CharacterDetailBusinessLogic
{
    func getCharacter(request: CharacterDetail.GetCharacter.Request)
}

protocol CharacterDetailDataStore
{
  var character: Character! { get set }
  var episodes: [Episode]? { get set }
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore
{

    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorker? = CharacterDetailWorker(charancterApi: EpisodesApi())
    var character: Character!
    var episodes: [Episode]?
  
  // MARK: Do something
  
    func getCharacter(request: CharacterDetail.GetCharacter.Request)
    {
        let response = CharacterDetail.GetCharacter.Response(character: character)
        presenter?.presentCharacter(response: response)
        
        if shouldFetchMultipleEpisodes()
        {
            fetchMultipleEpisodes()
        }
        
        if shouldFetchOneEpisode()
        {
            fetchSingleEpisode()
        }
    }
    
    // MARK: Fetch multiple episodes
    
    func shouldFetchMultipleEpisodes() -> Bool
    {
        return character.episode.count > 1
    }
    
    func getEpisodesId() -> [Int]
    {
        var episodesId = [Int]()
        for episodeUrl in character.episode {
            let episodeId = Int(episodeUrl.components(separatedBy: "/").last!)!
            episodesId.append(episodeId)
        }
        return episodesId
    }
    
    func fetchMultipleEpisodes()
    {
        let episodesId = getEpisodesId()
        worker?.fetchMultipleEpisodes(episodesIds: episodesId, completionHandler: { episodes in
            self.episodes = episodes
            let response = CharacterDetail.FetchEpisodes.Response(episodes: episodes)
            self.presenter?.presentEpisodes(response: response)
        }, errorHandler: { serviceOperationError in
            self.presenter?.presentOperationError(error: serviceOperationError)
        })
    }
    
    // MARK: fetch single episode
    
    func shouldFetchOneEpisode() -> Bool
    {
        return character.episode.count == 1
    }
    
    func getEpisodeId() -> Int
    {
        let episodeUrl = character.episode.first!
        return Int(episodeUrl.components(separatedBy: "/").last!)!
    }
    
    func fetchSingleEpisode()
    {
        let episodesId = getEpisodeId()
        worker?.fetchSingleEpisode(episodeId: episodesId, completionHandler: { episode in
            self.episodes = [episode]
            let response = CharacterDetail.FetchEpisodes.Response(episodes: self.episodes!)
            self.presenter?.presentEpisodes(response: response)
        }, errorHandler: { serviceOperationError in
            self.presenter?.presentOperationError(error: serviceOperationError)
        })
    }
}
