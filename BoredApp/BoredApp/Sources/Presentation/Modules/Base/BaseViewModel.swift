//
//  BaseViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit

struct BaseViewModel {
    
    private let userDefaults: UserDefaultManagering
    
    init(userDefaults: UserDefaultManagering = UserDefaultManager()) {
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
