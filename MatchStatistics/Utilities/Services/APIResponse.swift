//
//  APIResponse.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation

struct TeamsListResponse<T: Decodable>: Decodable {
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case data = "Teams"
    }
    
    init(from decodable: Decoder) throws {
        let container = try decodable.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(T.self, forKey: .data)
        print("line")
    }
}

struct MatchListResponse<T: Decodable>: Decodable {
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case data = "Matches"
    }
    
    init(from decodable: Decoder) throws {
        let container = try decodable.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(T.self, forKey: .data)
        print("line")
    }
}
