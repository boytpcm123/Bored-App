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
    private let userDefaults: UserDefaultManagering
    let publishListSettingType: BehaviorSubject<[ActivitySettingViewModel]>
    let publishIsSelectAll = BehaviorSubject<Bool>(value: true)
    
    init(userDefaults: UserDefaultManagering = UserDefaultManager()) {
        self.userDefaults = userDefaults
        
        let listSettingType: [ActivitySettingViewModel] = ActivityType.allCases
            .map { ActivitySettingViewModel(activityType: $0) }
        publishListSettingType = BehaviorSubject(value: listSettingType)
        
        self.loadSettingValues()
    }
}

// MARK: - PUBLIC FUNCTIONS
extension SettingScreenViewModel {
    
    func getTitleScreen() -> String {
        return "Setting"
    }
    
    func getNightModeSetting() -> Bool {
        let state = userDefaults.getBool(key: Constants.nightMode) ?? Constants.initNightMode
        return state
    }
    
    func getStateSelectAll() {
        let state = userDefaults.getBool(key: Constants.selectAllActivities) ?? Constants.initSelectAllActivities
        publishIsSelectAll.onNext(state)
    }
    
    func getNumberActivities() -> Float {
        let numberActivities = userDefaults.getInt(key: Constants.numberActivities) ?? Constants.initNumActivity
        return Float(numberActivities)
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
    
    func saveAllSetting(nightModeState: Bool,
                        selectAllState: Bool,
                        numberActivities: Float) {
        self.updateNightMode(withState: nightModeState)
        self.updateSelectAllActivities(withState: selectAllState)
        self.updateNumberActivites(withNumber: Int(numberActivities))
    }
}

// MARK: - PRIVATE FUNCTIONS
extension SettingScreenViewModel {
    
    fileprivate func loadSettingValues() {
        
    }
    
    fileprivate func updateNightMode(withState state: Bool) {
        userDefaults.setBool(key: Constants.nightMode, value: state)
    }
    
    fileprivate func updateSelectAllActivities(withState state: Bool) {
        userDefaults.setBool(key: Constants.selectAllActivities, value: state)
    }
    
    fileprivate func updateNumberActivites(withNumber number: Int) {
        userDefaults.setInt(key: Constants.numberActivities, value: number)
    }
}
