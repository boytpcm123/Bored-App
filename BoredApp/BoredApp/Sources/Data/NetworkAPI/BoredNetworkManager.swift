//
//  BoredNetworkManager.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import RxSwift
import Moya

protocol BoredNetworkManagerProtocol {
    
}

struct BoredNetworkManager: BoredNetworkManagerProtocol {
    
    private var provider: MoyaProvider<BoredService>!
    
    init() {
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        provider = MoyaProvider<BoredService>(plugins: [plugin])
    }
}

// MARK: - PUBLIC FUNCTIONS
extension BoredNetworkManager {
  
}

// MARK: - SUPPORT FUNCTIONS
extension BoredNetworkManager {
  
}
