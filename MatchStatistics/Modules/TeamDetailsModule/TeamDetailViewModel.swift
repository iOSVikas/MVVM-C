//
//  TeamDetailViewModel.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation

class TeamDetailViewModel {
    
    //MARK: Property declaration
    var viewController: TeamDetailViewProtocol?
    var wireframe: TeamDetailWireframe?
    
    //MARK: Variable declaration
    private let apiClient = APIProvider.client
    var selectedTeam: Team!
    var teams: [Team]!
    var mappedTeams: [MappedTeams] = [MappedTeams]()
    
    //MARK: Initializers
    init(viewController: TeamDetailViewProtocol,
         wireframe: TeamDetailWireframe,
         selectedTeam: Team,
         allTeams: [Team]) {
        self.viewController = viewController
        self.wireframe = wireframe
        self.selectedTeam = selectedTeam
        self.teams = allTeams
    }
}

extension TeamDetailViewModel: TeamDetailViewModelProtocol {
    func loadMatches() {
        viewController?.showLoader()
        getMatchList { [weak self] (matches, error) in
            if let leadedMatches = matches {
                guard let self = self else { return }
                let filterdMatches = self.getMatchesForSelectedTeamFrom(matches: leadedMatches) ?? [Match]()
                self.mappedTeams = self.mapTeams(matches: filterdMatches)
                self.viewController?.hideLoader()
                self.viewController?.matchesLoaded()
            }
            else {
                
            }
        }
    }
    
    func numberOfMatches() -> Int {
        return mappedTeams.count
    }
    
    func matchTeamsAt(index: IndexPath) -> MappedTeams? {
        guard index.row < mappedTeams.count else { return nil }
        return mappedTeams[index.row]
    }
}

private extension TeamDetailViewModel {
    func getMatchList( completionHandler: @escaping ((_ matches: [Match]?, _ error: Error?)->()) ) {
        apiClient.request(.fetchMatches, completion: { (result) in
            do {
                let matches =  try APIProvider.getMatchesResponse(forType: [Match].self, result: result)
                completionHandler(matches,nil)
            } catch _ {
                completionHandler(nil,MError.apiError("Unable to load records"))
            }
        })
    }
    
    func getMatchesForSelectedTeamFrom(matches: [Match]) -> [Match]? {
        let filteredMatches = matches.filter({ (match) -> Bool in
            let filteredMatchedTeams = match.teams.filter({ (matchTeam) -> Bool in
                return matchTeam.matchTeamID == self.selectedTeam.teamID
            })
            return filteredMatchedTeams.count > 0
        })
        return filteredMatches
    }
    
    func mapTeams(matches: [Match]) -> [MappedTeams] {
        let mappedTeams = matches.map({ (match) -> MappedTeams? in
            if match.teams.count == 2 {
                let sortedTeams = match.teams.sorted(by: { (teamOne, teamTwo) -> Bool in
                    return teamOne.score > teamTwo.score
                })
                guard let teamOne = self.getTeamFromId(teamId: sortedTeams[0].matchTeamID),
                    let teamTwo = self.getTeamFromId(teamId: sortedTeams[1].matchTeamID) else {
                        return nil
                }
                
                if match.teams[0].score == match.teams[1].score {
                    return MappedTeams(teamOne: teamOne, teamTwo: teamTwo, state: .draw)
                }
                else if teamOne.teamID == self.selectedTeam.teamID {
                    return MappedTeams(teamOne: teamOne, teamTwo: teamTwo, state: .winner)
                }
                else {
                    return MappedTeams(teamOne: teamOne, teamTwo: teamTwo, state: .looser)
                }
            }
            else {
                return nil
            }
        })
        return mappedTeams.compactMap { $0 }
    }
    
    func getTeamFromId(teamId: Int) -> Team? {
        let team = self.teams.filter { (team) -> Bool in
            return team.teamID == teamId
        }
        if team.count > 0 {
            return team[0]
        }
        else {
            return nil
        }
    }
}
