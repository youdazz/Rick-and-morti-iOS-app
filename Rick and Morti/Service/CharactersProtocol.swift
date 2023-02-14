//
//  CharactersProtocol.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 8/2/23.
//

import Foundation
// MARK: - Rick and Morti characters API

protocol CharactersProtocol
{
    func fetchCharacters(completionHandler: @escaping FetchCharactersCompletionHandler)
    func fetchNextPage(urlString: String, completionHandler: @escaping FetchCharactersCompletionHandler)
    func fetchCharacter(id: String, completionHandler: @escaping FetchCharacterCompletionHandler)
    func createCharacters(characters: [Character], completionHandler: @escaping CreateCharacterCompletionHandler)
    func deleteCharacters(completionHandler: @escaping DeleteCharacterCompletionHandler)
    func fetchCharactersWithFilter(filter: SearchCharacterFilter, completionHandler: @escaping FetchCharactersWithFilterCompletionHandler)
}

// MARK: - App CRUD operation results

typealias FetchCharactersCompletionHandler = (ServiceOperationResult<CharactersApiResponse>) -> Void
typealias FetchCharacterCompletionHandler = (ServiceOperationResult<Character>) -> Void
typealias CreateCharacterCompletionHandler = (ServiceOperationResult<[Character]>) -> Void
typealias DeleteCharacterCompletionHandler = (ServiceOperationResult<Bool>) -> Void
typealias FetchCharactersWithFilterCompletionHandler = (ServiceOperationResult<CharactersApiResponse>) -> Void

struct CharactersApiResponse: Codable {
    var info: PaginationInfo
    var results: [Character]
}
