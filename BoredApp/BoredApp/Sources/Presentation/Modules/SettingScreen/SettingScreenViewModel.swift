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
    let publishListSettingType = BehaviorSubject<[ActivitySettingViewModel]>(value: [])
    let publishIsSelectAll = BehaviorSubject<Bool>(value: true)
    let publishIsSettingChanged = BehaviorSubject<Bool>(value: false)
    
    init(userDefaults: UserDefaultManagering = UserDefaultManager()) {
        self.userDefaults = userDefaults
    
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
                           withData listSettingType: [ActivitySettingViewModel]) {
        
        var newListSettingType = listSettingType
        let activitySettingViewModel = listSettingType[index]
        let newStateSelect = !activitySettingViewModel.getStateSelected()
        
        let newStateViewModel = ActivitySettingViewModel(
            activityType: activitySettingViewModel.getActivityType(),
            isSelected: newStateSelect)
        newListSettingType[index] = newStateViewModel
        
        publishListSettingType.onNext(newListSettingType)
        
        // Bind UISwitch select all value
        checkUpdateSelectAllSwift(state: newStateSelect, withData: newListSettingType)
    }
    
    func updateSelectAllActivityType(_ value: Bool) {
        let listSettingType: [ActivitySettingViewModel] = ActivityType.allCases
            .map { ActivitySettingViewModel(activityType: $0, isSelected: value) }
        publishListSettingType.onNext(listSettingType)
    }
    
    func saveAllSetting(nightModeState: Bool,
                        selectAllState: Bool,
                        numberActivities: Float,
                        listSettingType: [ActivitySettingViewModel]) {
        self.updateNightMode(withState: nightModeState)
        self.updateSelectAllActivities(withState: selectAllState)
        
        if listSettingType != getListActivitySetting() {
            publishIsSettingChanged.onNext(true)
            self.updateListSettingType(withData: listSettingType)
        }
        
        if numberActivities != getNumberActivities() {
            publishIsSettingChanged.onNext(true)
            self.updateNumberActivites(withNumber: Int(numberActivities))
        }
    }
}

// MARK: - PRIVATE FUNCTIONS
extension SettingScreenViewModel {
    
    fileprivate func loadSettingValues() {
        let listSettingType = getListActivitySetting()
        publishListSettingType.onNext(listSettingType)
    }
    
    fileprivate func getListActivitySetting() -> [ActivitySettingViewModel] {
        return userDefaults.getListActivitySetting()
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
    
    fileprivate func updateListSettingType(withData listSettingType: [ActivitySettingViewModel]) {
        userDefaults.setListActivitySetting(value: listSettingType)
    }
    
    fileprivate func checkUpdateSelectAllSwift(state: Bool,
                                               withData listSettingType: [ActivitySettingViewModel]) {
        if state {
            let numNoneSelectType = listSettingType.filter { !$0.getStateSelected() }.count
            if numNoneSelectType == 0 {
                publishIsSelectAll.onNext(true)
            }
        } else {
            publishIsSelectAll.onNext(false)
        }
    }
}
