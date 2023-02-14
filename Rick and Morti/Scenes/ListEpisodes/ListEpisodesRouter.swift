//
//  ListEpisodesRouter.swift
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

@objc protocol ListEpisodesRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ListEpisodesDataPassing
{
  var dataStore: ListEpisodesDataStore? { get }
}

class ListEpisodesRouter: NSObject, ListEpisodesRoutingLogic, ListEpisodesDataPassing
{
  weak var viewController: ListEpisodesViewController?
  var dataStore: ListEpisodesDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: ListEpisodesViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ListEpisodesDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
