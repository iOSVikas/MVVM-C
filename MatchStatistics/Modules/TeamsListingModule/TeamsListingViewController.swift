//
//  TeamsListingViewController.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import UIKit

class TeamsListingViewController: UIViewController {
    
    //MARK: property declaration
    var viewModel: TeamsListingViewModelProtocol?
    
    //MARK: Outlet declaration
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Initializers
    static func create(wireframe: TeamListingWireframe) -> TeamsListingViewController {
        let viewController = TeamsListingViewController(nibName: "TeamsListingViewController",
                                                        bundle: .main)
        viewController.viewModel = TeamsListingViewModel(viewController: viewController,
                                                         wireframe: wireframe)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadTeams()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 55
        tableView.register(UINib(nibName: TeamsTableViewCell.identifire, bundle: .main), forCellReuseIdentifier: TeamsTableViewCell.identifire)
    }
}

extension TeamsListingViewController: TeamListingViewProtocol {
    func teamsLoaded() {
        tableView.reloadData()
    }
    
    func showLoader() {
        Loader.shared.showLoader(message: "Please wait..")
    }
    
    func hideLoader() {
        Loader.shared.hideLoader()
    }
}

extension TeamsListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfTeams() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let team = viewModel?.teamAt(index: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.identifire, for: indexPath) as! TeamsTableViewCell
        cell.configure(team: team)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.userSelectedTeamAt(index: indexPath)
    }
}
