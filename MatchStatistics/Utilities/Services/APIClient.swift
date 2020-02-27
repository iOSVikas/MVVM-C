//
//  APIClient.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation
import Moya

enum APIClient {
    case fetchTeams
    case fetchMatches
}


extension APIClient: TargetType {
    var baseURL: URL {
        return URL(string: "https://headytestjson.s3.amazonaws.com/ios-express-sat/")!
    }
    
    var path: String {
        switch self {
        case .fetchTeams:
            return "teams.json"
        case .fetchMatches:
            return "matches.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchTeams, .fetchMatches:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
