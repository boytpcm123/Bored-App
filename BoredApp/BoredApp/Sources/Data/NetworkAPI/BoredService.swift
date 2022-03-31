//
//  BoredService.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation
import Moya

enum BoredService {
    case getActivity(String)
}

extension BoredService: TargetType {
    
    // swiftlint:disable:next force_unwrapping
    var baseURL: URL { URL(string: "https://www.boredapi.com/api")! }
    
    var path: String {
        switch self {
        case .getActivity:
            return "/activity"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getActivity:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getActivity(let activityType):
            return .requestParameters(parameters: ["type": "\(activityType)"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        Data()
    }
    
}
