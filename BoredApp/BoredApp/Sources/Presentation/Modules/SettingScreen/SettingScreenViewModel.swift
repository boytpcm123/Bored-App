//
//  SettingScreenViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import Foundation
import RxSwift

struct SettingScreenViewModel {
    
    // MARK: - PROPERTIES
    let publishListSettingType: BehaviorSubject<[ActivitySettingViewModel]>
    let publishIsSelectAll = BehaviorSubject<Bool>(value: true)
    
    init() {
        let listSettingType: [ActivitySettingViewModel] = ActivityType.allCases
            .map { ActivitySettingViewModel(activityType: $0) }
        publishListSettingType = BehaviorSubject(value: listSettingType)
    }
}

// MARK: - PUBLIC FUNCTIONS
extension SettingScreenViewModel {
    
    func getTitleScreen() -> String {
        return "Setting"
    }
    
    func updateStateSelect(atIndex index: Int,
                           data listSettingType: [ActivitySettingViewModel]) {
        
        var newListSettingType = listSettingType
        let activitySettingViewModel = listSettingType[index]
        let newStateSelect = !activitySettingViewModel.getStateSelected()
        
        let newStateViewModel = ActivitySettingViewModel(
            activityType: activitySettingViewModel.getActivityType(),
            isSelected: newStateSelect)
        newListSettingType[index] = newStateViewModel
        
        publishListSettingType.onNext(newListSettingType)
        
        // Bind UISwitch select all value
        if newStateSelect == false { publishIsSelectAll.onNext(false) }
    }
    
    func updateSelectAllActivityType(_ value: Bool) {
        guard value else { return }
        
        let listSettingType: [ActivitySettingViewModel] = ActivityType.allCases
            .map { ActivitySettingViewModel(activityType: $0) }
        publishListSettingType.onNext(listSettingType)
    }
}

// MARK: - PRIVATE FUNCTIONS
extension SettingScreenViewModel {
}
