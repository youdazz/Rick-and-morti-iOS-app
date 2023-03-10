//
//  ListCharactersPresenter.swift
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

protocol ListCharactersPresentationLogic
{
    func presentFetchedCharacters(characters: [Character], hasNextPage: Bool)
    func presentFetchedCharactersStoredData(characters: [Character], hasNextPage: Bool)
    func presentNewPageCharacters(characters: [Character], hasNextPage: Bool)
    func presentOperationError(error: ServiceOperationError)
    func stopRefreshAnimation()
}

class ListCharactersPresenter: ListCharactersPresentationLogic
{
  weak var viewController: ListCharactersDisplayLogic?
  
    func stopRefreshAnimation() {
        DispatchQueue.main.async {
            self.viewController?.stopRefreshAnimation()
        }
    }
    
    func presentFetchedCharacters(characters: [Character], hasNextPage: Bool){
        var displayedCharacters: [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter] = []
        for character in characters {
            let displayedCharacter = ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter(id: character.id, image: character.image, name: character.name, race: character.origin.name, status: character.status.rawValue)
            displayedCharacters.append(displayedCharacter)
        }
        let viewModel = ListCharacters.FetchCharacters.ViewModel(displayedCharacters: displayedCharacters,hasNextPage: hasNextPage)
        DispatchQueue.main.async {
            self.viewController?.displayFetchedCharacters(viewModel: viewModel)
        }
    }
    
    func presentFetchedCharactersStoredData(characters: [Character], hasNextPage: Bool){
        var displayedCharacters: [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter] = []
        for character in characters {
            let displayedCharacter = ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter(id: character.id, image: character.image, name: character.name, race: character.origin.name, status: character.status.rawValue)
            displayedCharacters.append(displayedCharacter)
        }
        let viewModel = ListCharacters.FetchCharacters.ViewModel(displayedCharacters: displayedCharacters,hasNextPage: hasNextPage)
        DispatchQueue.main.async {
            self.viewController?.displayFetchedCharactersStoredData(viewModel: viewModel)
        }
    }
    
    func presentOperationError(error: ServiceOperationError){
        DispatchQueue.main.async {
            var error_message = ""
            switch error{
            case .CannotFetch(let msg):
                error_message = msg
            case .CannotCreate(let msg):
                error_message = msg
            case .CannotDelete(let msg):
                error_message = msg
            }
            self.viewController?.displayError(msg: error_message)
        }
    }
    
    func presentNewPageCharacters(characters: [Character], hasNextPage: Bool){
        var displayedCharacters: [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter] = []
        for character in characters {
            let displayedCharacter = ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter(id: character.id, image: character.image, name: character.name, race: character.origin.name, status: character.status.rawValue)
            displayedCharacters.append(displayedCharacter)
        }
        let viewModel = ListCharacters.FetchCharacters.ViewModel(displayedCharacters: displayedCharacters,hasNextPage: hasNextPage)
        DispatchQueue.main.async {
            self.viewController?.displayNewPageCharacters(viewModel: viewModel)
        }
    }
}
