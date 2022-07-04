//
//  BaseViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit

protocol BaseViewModelProtocol {

    func getNightModeSetting() -> Bool
}

struct BaseViewModel: BaseViewModelProtocol {
    
    private let userDefaults: UserDefaultManagerProtocol
    
    init(userDefaults: UserDefaultManagerProtocol = UserDefaultManager()) {
        self.userDefaults = userDefaults
    }
}

// MARK: - CONFIG
extension BaseViewModel {
    
    func getNightModeSetting() -> Bool {
        return userDefaults.getNightModeSetting()
    }
}

// MARK: - SUPPORT FUNCTIONS
extension BaseViewModel {
    
}
