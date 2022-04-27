//
//  GeneralAssembly.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/25/22.
//

import Foundation
import Swinject

final class GeneralAssembly: Assembly {

    func assemble(container: Container) {

        container.register(UserDefaultManagerProtocol.self,
                           factory: { _ in
            UserDefaultManager()
        })
            .inObjectScope(.container)

        container.register(BoredNetworkManagerProtocol.self,
                           factory: { _ in
            BoredNetworkManager()
        })
            .inObjectScope(.container)
    }
}
