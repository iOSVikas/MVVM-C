//
//  TeamListingProtocol.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation

protocol TeamListingWireframe {
    func userWantToSeeDetailsFor(team: Team, fromAllTeams: [Team])
}

protocol TeamListingViewProtocol {
    func teamsLoaded()
    func showLoader()
    func hideLoader()
}

protocol TeamsListingViewModelProtocol {
    func loadTeams()
    func numberOfTeams() -> Int
    func teamAt(index: IndexPath) -> Team?
    func userSelectedTeamAt(index: IndexPath)
}
