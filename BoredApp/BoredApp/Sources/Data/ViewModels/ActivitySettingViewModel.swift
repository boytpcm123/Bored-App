//
//  ActivitySettingViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/1/22.
//

import Foundation

struct ActivitySettingViewModel {
    
    private let activityType: ActivityType
    private var isSelected: Bool
    
    init(activityType: ActivityType, isSelected: Bool = true) {
        self.activityType = activityType
        self.isSelected = isSelected
    }
}

// MARK: - SUPPORT FUNCTIONS
extension ActivitySettingViewModel {
    
    func getNameActivity() -> String {
        return activityType.description
    }
    
    func getStateSelected() -> Bool {
        return isSelected
    }
    
    func getActivityType() -> ActivityType {
        return activityType
    }
}
