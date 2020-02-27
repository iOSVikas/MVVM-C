//
//  MatchTableCell.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import UIKit

enum State {
    case winner
    case looser
    case draw
}

class MatchTableCell: UITableViewCell {

    static let identifire = "MatchTableCell"
    
    @IBOutlet weak var teamNames: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(mappedTeams: MappedTeams) {
        teamNames.text = teamsTitle(for: mappedTeams)
        switch mappedTeams.state {
        case .winner:
            teamNames.backgroundColor = .green
        case .looser:
            teamNames.backgroundColor = .red
        default:
            teamNames.backgroundColor = .white
        }
    }
    
    private func teamsTitle(for teams: MappedTeams) -> String {
        return "\(teams.teamOne.name) V/S \(teams.teamTwo.name)"
    }
}
