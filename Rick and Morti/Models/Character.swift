//
//  Character.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
struct Character: Codable {
    var id: Int
    var name: String
    var status: CharacterStatus
    var species: String
    var type: String
    var gender: CharacterGender
    var origin: CharacterLocation
    var location: CharacterLocation
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

struct CharacterLocation: Codable {
    var name: String
    var url: String
}
