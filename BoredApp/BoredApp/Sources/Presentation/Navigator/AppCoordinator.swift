//
//  AppCoordinator.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/25/22.
//

import Foundation
import XCoordinator

typealias SettingChanged = ((_ settingChanged: Bool) -> Void)

enum AppRoute: Route {
    case home
    case setting(SettingChanged)
    case detail(ActivityViewModel)
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    init() {
        super.init(initialRoute: .home)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .home:
            
            let viewModel = HomeScreenViewModel(router: unownedRouter)
            let controller = HomeScreenController(viewModel: viewModel)
            return .push(controller)
        case .setting(let settingChanged):
            
            let viewModel = SettingScreenViewModel(router: unownedRouter)
            let controller = SettingScreenController(viewModel: viewModel,
                                                     onApplySaveSetting: settingChanged)
            return .present(controller, animation: .default)
        case .detail(let activity):
            
            let viewModel = DetailScreenViewModel(router: unownedRouter, activity: activity)
            let controller = DetailScreenViewController(viewModel: viewModel)
            return .push(controller)
        }
    }
}
