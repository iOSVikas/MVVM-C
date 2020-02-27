//
//  Match.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation

class Match: Codable {
    let matchID: Int
    let teams: [MatchTeam]
    
    private enum CodingKeys: String, CodingKey {
        case matchID = "id"
        case teams = "Teams"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(matchID, forKey: .matchID)
        try container.encode(teams, forKey: .teams)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matchID = try container.decode(Int.self, forKey: .matchID)
        self.teams = try container.decode([MatchTeam].self, forKey: .teams)
    }
}

class MatchTeam: Codable {
    let matchTeamID: Int
    let score: Int
    
    private enum CodingKeys: String, CodingKey {
        case matchTeamID = "id"
        case score = "score"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(matchTeamID, forKey: .matchTeamID)
        try container.encode(score, forKey: .score)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matchTeamID = try container.decode(Int.self, forKey: .matchTeamID)
        self.score = try container.decode(Int.self, forKey: .score)
    }
}


struct MappedTeams {
    let teamOne: Team
    let teamTwo: Team
    let state: State
}
