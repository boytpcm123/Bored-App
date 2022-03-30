//
//  BoredService.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit
import Moya

enum BoredService {
    case getCallList
    case getBuyList
}

extension BoredService: TargetType {
    
    var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "")!
    }
    
    var path: String {
        switch self {
        case .getCallList:
            return "/call"
        case .getBuyList:
            return "/buy"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCallList:
            return .get
        case .getBuyList:
            return .get
        }
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        Data()
    }
    
}
