//
//  Team.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation

class Team: Codable {
    let teamID: Int
    let name: String
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case teamID = "id"
        case name = "name"
        case image = "image"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(teamID, forKey: .teamID)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.teamID = try container.decode(Int.self, forKey: .teamID)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
    }
}
