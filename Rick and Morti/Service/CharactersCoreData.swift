//
//  CharactersCoreData.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
import CoreData
import UIKit

class CharactersCoreData: CharactersProtocol {
    func fetchCharactersWithFilter(filter: SearchCharacterFilter, completionHandler: @escaping FetchCharactersWithFilterCompletionHandler) {
        
    }
    
    
    // MARK: - Managed object contexts
    
    var managedObjectContext: NSManagedObjectContext
    
    // MARK: - Object lifecycle
    
    init(){
        self.managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func createCharacters(characters: [Character], completionHandler: @escaping CreateCharacterCompletionHandler)
    {
        do {
            for character in characters {
                let managedCharacter = NSEntityDescription.insertNewObject(forEntityName: "ManagedCharacter", into: self.managedObjectContext) as! ManagedCharacter
                managedCharacter.fromCharacter(character: character)
                try self.managedObjectContext.save()
            }
            completionHandler(ServiceOperationResult.Success(result: characters))
        } catch {
            completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
        }
    }
    
    func fetchNextPage(urlString: String, completionHandler: @escaping FetchCharactersCompletionHandler) {
        
    }
    
    func fetchCharacters(completionHandler: @escaping FetchCharactersCompletionHandler) {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedCharacter")
            let results = try self.managedObjectContext.fetch(fetchRequest) as! [ManagedCharacter]
            let characters = results.map { $0.toCharacter() }
            let response = CharactersApiResponse(info: PaginationInfo(count: -1, pages: -1), results: characters)
            completionHandler(ServiceOperationResult.Success(result: response))
        } catch {
            completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
        }
    }
    
    func fetchCharacter(id: String, completionHandler: @escaping FetchCharacterCompletionHandler) {
        
    }
    
    func deleteCharacters(completionHandler: @escaping DeleteCharacterCompletionHandler) {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedCharacter")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
            completionHandler(ServiceOperationResult.Success(result: true))
        } catch {
            completionHandler(ServiceOperationResult.Failure(error: ServiceOperationError.CannotFetch("Cannot fetch characters")))
        }
    }
    
}
