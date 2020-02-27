//
//  TeamsListingViewModel.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation

class TeamsListingViewModel {
    
    //MARK: Property declaration
    var viewController: TeamListingViewProtocol?
    var wireframe: TeamListingWireframe?

    //MARK: Variable declaration
    private let apiClient = APIProvider.client
    var teams: [Team] = [Team]()
    
    //MARK: Initializers
    init(viewController: TeamListingViewProtocol,
         wireframe: TeamListingWireframe) {
        self.viewController = viewController
        self.wireframe = wireframe
    }
}

extension TeamsListingViewModel: TeamsListingViewModelProtocol {
    
    func loadTeams() {
        viewController?.showLoader()
        getTeamsList { [weak self] (teams, error) in
            guard let self = self else { return }
            if let teams = teams {
                self.teams = teams
                self.viewController?.hideLoader()
                self.viewController?.teamsLoaded()
            }
        }
    }
    
    func numberOfTeams() -> Int {
        return teams.count
    }
    
    func teamAt(index: IndexPath) -> Team? {
        guard index.row < teams.count else { return nil }
        return teams[index.row]
    }
    
    func userSelectedTeamAt(index: IndexPath) {
        guard index.row < teams.count else { return }
        let team = teams[index.row]
        wireframe?.userWantToSeeDetailsFor(team: team, fromAllTeams: teams)
    }
}

private extension TeamsListingViewModel {
    func getTeamsList( completionHandler: @escaping ((_ teams: [Team]?, _ error: Error?)->()) ) {
        apiClient.request(.fetchTeams, completion: { (result) in
            do {
                let teams =  try APIProvider.getTeamsResponse(forType: [Team].self, result: result)
                completionHandler(teams,nil)
            } catch _ {
                completionHandler(nil,MError.apiError("Unable to load records"))
            }
        })
    }
}
