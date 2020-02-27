//
//  TeamDetailViewController.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {
    
    //MARK: property declaration
    var viewModel: TeamDetailViewModelProtocol?
    
    //MARK: Outlet declaration
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Initializers
    static func create(wireframe: TeamDetailWireframe, selectedTeam: Team, allTeams: [Team]) -> TeamDetailViewController {
        let viewController = TeamDetailViewController(nibName: "TeamDetailViewController",
                                                        bundle: .main)
        viewController.viewModel = TeamDetailViewModel(viewController: viewController,
                                                         wireframe: wireframe,
                                                         selectedTeam: selectedTeam,
                                                         allTeams: allTeams)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadMatches()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 55
        tableView.rowHeight = 55
        tableView.register(UINib(nibName: MatchTableCell.identifire, bundle: .main), forCellReuseIdentifier: MatchTableCell.identifire)
    }
}

extension TeamDetailViewController: TeamDetailViewProtocol {
    func matchesLoaded() {
        tableView.reloadData()
    }
    
    func showLoader() {
        Loader.shared.showLoader(message: "Please wait..")
    }
    
    func hideLoader() {
        Loader.shared.hideLoader()
    }
}

extension TeamDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfMatches() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let matchTeams = viewModel?.matchTeamsAt(index: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableCell.identifire, for: indexPath) as! MatchTableCell
        cell.configure(mappedTeams: matchTeams)
        return cell
    }
}
