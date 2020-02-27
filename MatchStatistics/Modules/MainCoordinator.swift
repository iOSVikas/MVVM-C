//
//  MainCoordinator.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let teamList = TeamsListingViewController.create(wireframe: self)
        navigator.pushViewController(teamList, animated: true)
    }
}

extension MainCoordinator: TeamListingWireframe {
    func userWantToSeeDetailsFor(team: Team, fromAllTeams: [Team]) {
        let teamDetails = TeamDetailViewController.create(wireframe: self, selectedTeam: team, allTeams: fromAllTeams)
        navigator.pushViewController(teamDetails, animated: true)
    }
}

extension MainCoordinator: TeamDetailWireframe {

}
