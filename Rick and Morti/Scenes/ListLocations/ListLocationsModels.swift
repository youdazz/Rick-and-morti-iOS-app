//
//  ListLocationsModels.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 10/2/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ListLocations
{
  // MARK: Use cases
  
  enum FetchLocations
  {
    struct Request
    {
    }
    struct Response
    {
    }
    struct ViewModel
    {
        struct DisplayedLocation{
            var name: String
            var type: String
            var dimension: String
            var residentsCount: Int
        }
        var displayedLocations: [DisplayedLocation]
        var hasNextPage: Bool
    }
  }
}
