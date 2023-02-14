//
//  Episode.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
struct Episode: Codable {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
    var url: String
    var created: String
}
