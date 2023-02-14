//
//  PaginationInfo.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
struct PaginationInfo: Codable{
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
