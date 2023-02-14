//
//  ListEpisodesViewController.swift
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

protocol ListEpisodesDisplayLogic: AnyObject
{
    func displayFetchesEpisodes(viewModel: ListEpisodes.FetchEpisodes.ViewModel)
    func displayNewPageEpisodes(viewModel: ListEpisodes.FetchEpisodes.ViewModel)
    func displayError(msg: String)
    func stopRefreshAnimation()
}

class ListEpisodesViewController: UITableViewController, ListEpisodesDisplayLogic
{
    
  var interactor: ListEpisodesBusinessLogic?
  var router: (NSObjectProtocol & ListEpisodesRoutingLogic & ListEpisodesDataPassing)?
  
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
    let interactor = ListEpisodesInteractor()
    let presenter = ListEpisodesPresenter()
    let router = ListEpisodesRouter()
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
    fetchEpisodes()
      self.tableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "episode_cell")
      
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshCharactersData(_:)), for: .valueChanged)
    self.tableView.refreshControl = refreshControl
  }
  
  @objc func refreshCharactersData(_ sender: Any?){
      fetchEpisodes()
  }
  
    
    // MARK: Fetch Episodes
    var displayedEpisodes: [ListEpisodes.FetchEpisodes.ViewModel.DisplayedEpisode] = []
    
    func fetchEpisodes(){
        let request = ListEpisodes.FetchEpisodes.Request()
        interactor?.fetchFirstPageEpisodes(request: request)
    }
    
    func displayFetchesEpisodes(viewModel: ListEpisodes.FetchEpisodes.ViewModel) {
        self.hasNextPage = viewModel.hasNextPage
        displayedEpisodes = viewModel.displayedEpisodes
        tableView.reloadData()
    }
    
    func displayError(msg: String) {
        self.showAlert(title: "Error", message: msg)
    }
    
    func stopRefreshAnimation() {
        self.tableView.refreshControl?.endRefreshing()
    }
    
    //MARK: Tableview data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedEpisodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = self.displayedEpisodes[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "episode_cell") as! EpisodeTableViewCell
        cell.setEpisode(episode: episode)
        return cell
    }
    
    //MARK: Pagination
    var hasNextPage = false
    var isFetchingNextPage = false
    
    func displayNewPageEpisodes(viewModel: ListEpisodes.FetchEpisodes.ViewModel) {
        self.hasNextPage = viewModel.hasNextPage
        self.displayedEpisodes.append(contentsOf: viewModel.displayedEpisodes)
        self.tableView.reloadData()
        self.isFetchingNextPage = false
        self.tableView.tableFooterView = nil
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard hasNextPage == true else{
            return
        }
        
        let ROW_HEIGHT: Float = 82.0
        let NUMBER_OF_ROW_BEFORE_LOADING: Float = 4
        let ROWS_HEIGHT_BEFORE_LOADING = ROW_HEIGHT * NUMBER_OF_ROW_BEFORE_LOADING
        
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - CGFloat(ROWS_HEIGHT_BEFORE_LOADING)) - scrollView.frame.size.height  {
            guard !self.isFetchingNextPage else {
                return
            }
            fetchNextPage()
        }
    }
    
    
    func fetchNextPage(){
        self.isFetchingNextPage = true
        DispatchQueue.main.async {
            self.tableView.tableFooterView = self.createFotterSpinnerView()
        }
        
        let request = ListEpisodes.FetchEpisodes.Request()
        interactor?.fetchNextPageEpisodes(request: request)
    }

}