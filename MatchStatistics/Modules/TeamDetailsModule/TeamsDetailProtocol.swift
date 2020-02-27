//
//  TeamDetailProtocol.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation

protocol TeamDetailWireframe {
}

protocol TeamDetailViewProtocol {
    func matchesLoaded()
    func showLoader()
    func hideLoader()
}

protocol TeamDetailViewModelProtocol {
    func loadMatches()
    func numberOfMatches() -> Int
    func matchTeamsAt(index: IndexPath) -> MappedTeams?
}
