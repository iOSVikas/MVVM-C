//
//  APIProvider.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import Foundation
import Moya
import enum Result.Result

class APIProvider {
    static let client = MoyaProvider<APIClient>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static func getTeamsResponse<T:Decodable>(forType type: T.Type, result: Result<Moya.Response, MoyaError>) throws -> T {
        switch result {
        case .success(let response):
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(TeamsListResponse<T>.self, from: response.data)
            guard let data = apiResponse.data else { throw MError.apiError("Faild to fetch data") }
            return data
        case .failure(let error):
            throw error
        }
    }
    
    static func getMatchesResponse<T:Decodable>(forType type: T.Type, result: Result<Moya.Response, MoyaError>) throws -> T {
        switch result {
        case .success(let response):
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(MatchListResponse<T>.self, from: response.data)
            guard let data = apiResponse.data else { throw MError.apiError("Faild to fetch data") }
            return data
        case .failure(let error):
            throw error
        }
    }
}

enum MError : Error {
    case apiError(String)
    
    var errorTitle: String {
        return NSLocalizedString("Something went wrong", comment: "")
    }
    
    var localizedDescription: String {
        switch self {
        case .apiError(let string):
            return NSLocalizedString(string, comment: "")
        }
    }
}
