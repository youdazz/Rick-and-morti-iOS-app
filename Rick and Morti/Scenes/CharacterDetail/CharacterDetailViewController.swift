//
//  CharacterDetailViewController.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CharacterDetailDisplayLogic: AnyObject
{
  func displayCharacter(viewModel: CharacterDetail.GetCharacter.ViewModel)
    func displayError(msg: String)
    func displayFetchedEpisodes(viewModel: CharacterDetail.FetchEpisodes.ViewModel)
}

class CharacterDetailViewController: UITableViewController, CharacterDetailDisplayLogic
{
    
  var interactor: CharacterDetailBusinessLogic?
  var router: (NSObjectProtocol & CharacterDetailRoutingLogic & CharacterDetailDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = CharacterDetailInteractor()
    let presenter = CharacterDetailPresenter()
    let router = CharacterDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    getCharacter()
  }
  
  // MARK: Do something
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameCell: UITableViewCell!
  @IBOutlet weak var statusCell: UITableViewCell!
  @IBOutlet weak var specieCell: UITableViewCell!
  @IBOutlet weak var typeCell: UITableViewCell!
  @IBOutlet weak var genderCell: UITableViewCell!
  @IBOutlet weak var originCell: UITableViewCell!
  @IBOutlet weak var locationCell: UITableViewCell!
  
  func getCharacter()
  {
    let request = CharacterDetail.GetCharacter.Request()
    interactor?.getCharacter(request: request)
  }
  
  func displayCharacter(viewModel: CharacterDetail.GetCharacter.ViewModel)
  {
      loadImage(urlString: viewModel.character.image)
      nameCell.detailTextLabel?.text = viewModel.character.name
      statusCell.detailTextLabel?.text = viewModel.character.status.rawValue
      specieCell.detailTextLabel?.text = viewModel.character.species
      typeCell.detailTextLabel?.text = viewModel.character.type
      genderCell.detailTextLabel?.text = viewModel.character.gender.rawValue
      originCell.detailTextLabel?.text = viewModel.character.origin.name
      locationCell.detailTextLabel?.text = viewModel.character.location.name
  }
    
    func loadImage(urlString: String){
        getRemoteImage(from: urlString) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func displayError(msg: String){
        self.showAlert(title: "Error", message: msg)
    }
    
    var episodes: [CharacterDetail.FetchEpisodes.ViewModel.DisplayedEpisode] = []
    
    func displayFetchedEpisodes(viewModel: CharacterDetail.FetchEpisodes.ViewModel) {
        self.episodes.removeAll()
        self.episodes.append(contentsOf: viewModel.displayedEpisodes)
        self.tableView.reloadData()
    }
    
    // MARK: Tableview Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 2 else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 2 else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        let episode = episodes[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "episode_cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "episode_cell")
        }
        cell?.textLabel?.text = episode.episode
        cell?.detailTextLabel?.text = episode.name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section == 2 else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
        return 44
    }
    
}
