//
//  ManagedCharacter+CoreDataClass.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 9/2/23.
//
//

import Foundation
import CoreData

@objc(ManagedCharacter)
public class ManagedCharacter: NSManagedObject {
    
    func toCharacter() -> Character
    {
        let characterStatus = CharacterStatus(rawValue: status!) ?? CharacterStatus.unknown
        let characterGender = CharacterGender(rawValue: gender!) ?? CharacterGender.unknown
        let origin = CharacterLocation(name: originName!, url: originUrl!)
        let location = CharacterLocation(name: locationName!, url: locationUrl!)
        let episodesArr = episodes as? [String]
        
        return Character(id: Int(id), name: name!, status: characterStatus, species: specie!, type: type!, gender: characterGender, origin: origin, location: location, image: image!, episode: episodesArr ?? [], url: url!, created: created!)
    }
    
    func fromCharacter(character: Character)
    {
        id = Int16(character.id)
        name = character.name
        status = character.status.rawValue
        specie = character.species
        type = character.type
        gender = character.gender.rawValue
        originName = character.origin.name
        originUrl = character.origin.url
        locationName = character.location.name
        locationUrl = character.location.url
        image = character.image
        episodes = character.episode as NSObject
        url = character.url
        created = character.created
    }
}
