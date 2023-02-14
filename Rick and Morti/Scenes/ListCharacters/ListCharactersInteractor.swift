//
//  ListCharactersInteractor.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 4/2/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListCharactersBusinessLogic
{
    func fetchFirstPageCharactersFromNetwork(request: ListCharacters.FetchCharacters.Request)
    func fetchFirstPageCharactersFromCoreData(request: ListCharacters.FetchCharacters.Request)
    func fetchNextPageCharacters(request: ListCharacters.FetchCharacters.Request)
}

protocol ListCharactersDataStore
{
    var paginationInfo: PaginationInfo? {get set}
    var characters: [Character]? { get set}
}

class ListCharactersInteractor: ListCharactersBusinessLogic, ListCharactersDataStore
{
    
    var presenter: ListCharactersPresentationLogic?
    var worker: ListCharactersWorker = ListCharactersWorker(charactersApi: CharactersApi(), charactersCoreData: CharactersCoreData())
    var characters: [Character]?
    var paginationInfo: PaginationInfo?
    var firstPageDidFinishLoadingFromNetwork = false
  
    // MARK: Fetch characters
    func fetchFirstPageCharactersFromNetwork(request: ListCharacters.FetchCharacters.Request) {
        worker.fetchCharactersFromNetwork { response in
            self.firstPageDidFinishLoadingFromNetwork = true
            self.paginationInfo = response.info
            self.characters = response.results
            let hasNextPage = response.info.next != nil
            self.presenter?.presentFetchedCharacters(characters: response.results, hasNextPage: hasNextPage)
            self.presenter?.stopRefreshAnimation()
        } errorHandler: { serviceOperationError in
            self.presenter?.presentOperationError(error: serviceOperationError)
        }
    }
    
    func fetchFirstPageCharactersFromCoreData(request: ListCharacters.FetchCharacters.Request) {
        worker.fetchCharactersFromCoreData { response in
            guard !self.firstPageDidFinishLoadingFromNetwork else {
                return
            }
            self.paginationInfo = response.info
            self.characters = response.results
            let hasNextPage = response.info.next != nil
            self.presenter?.presentFetchedCharactersStoredData(characters: response.results, hasNextPage: hasNextPage)
        } errorHandler: { serviceOperationError in
            self.presenter?.presentOperationError(error: serviceOperationError)
        }
    }
    
    func fetchNextPageCharacters(request: ListCharacters.FetchCharacters.Request){
        guard let nextUrl = paginationInfo?.next else {
            return
        }
        worker.fetchNextPage(urlString: nextUrl) { response in
            self.paginationInfo = response.info
            self.characters?.append(contentsOf: response.results)
            let hasNextPage = response.info.next != nil
            self.presenter?.presentNewPageCharacters(characters: response.results, hasNextPage: hasNextPage)
        } errorHandler: { serviceOperationError in
            self.presenter?.presentOperationError(error: serviceOperationError)
        }
    }
    
    
}
