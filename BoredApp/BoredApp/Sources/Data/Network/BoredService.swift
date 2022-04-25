//
//  BoredService.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import Foundation
import Moya

enum BoredService {
    case getActivity(ActivityType)
}

extension BoredService: TargetType {
    
    // swiftlint:disable:next force_unwrapping
    var baseURL: URL { URL(string: Constants.API.base)! }
    
    var path: String {
        switch self {
        case .getActivity:
            return Constants.API.activity
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
            return .requestParameters(parameters: ["type": "\(activityType.description)"],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        Data()
    }
    
}
