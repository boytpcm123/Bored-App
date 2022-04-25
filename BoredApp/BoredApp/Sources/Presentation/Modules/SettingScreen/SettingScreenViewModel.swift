//
//  SettingScreenViewModel.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import Foundation
import RxSwift
import RxCocoa
import XCoordinator

struct SettingScreenViewModel {
    
    // MARK: - PROPERTIES
    private let router: UnownedRouter<AppRoute>?
    private let userDefaults: UserDefaultManagerProtocol
    
    var dataList = BehaviorRelay(value: [ActivitySettingViewModel]())
    let publishIsSelectAll = BehaviorSubject<Bool>(value: true)
    let publishIsSettingChanged = BehaviorSubject<Bool>(value: false)
    
    init(router: UnownedRouter<AppRoute>? = nil,
         userDefaults: UserDefaultManagerProtocol = UserDefaultManager()) {
        self.router = router
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
        return userDefaults.getNightModeSetting()
    }
    
    func getStateSelectAll() {
        let state = userDefaults.getSelectAllActivitiesSetting()
        publishIsSelectAll.onNext(state)
    }
    
    func getNumberActivities() -> Float {
        let numberActivities = userDefaults.getNumberActivitiesSetting()
        return Float(numberActivities)
    }
    
    func updateStateSelect(atIndex index: Int) {
        
        var newListSettingType = dataList.value
        let activitySetting = dataList.value[index]
        let newStateSelect = !activitySetting.getStateSelected()
        
        let newStateViewModel = ActivitySettingViewModel(
            activityType: activitySetting.getActivityType(),
            isSelected: newStateSelect)
        newListSettingType[index] = newStateViewModel

        dataList.accept(newListSettingType)

        // Bind UISwitch select all value
        checkUpdateSelectAllSwift(state: newStateSelect, withData: newListSettingType)
    }
    
    func updateSelectAllActivityType(_ value: Bool) {
        let listSettingType: [ActivitySettingViewModel] = ActivityType.allCases
            .map { ActivitySettingViewModel(activityType: $0, isSelected: value) }
        dataList.accept(listSettingType)
    }
    
    func saveNightModeValue(withState state: Bool) {
        userDefaults.setNightModeSetting(value: state)
    }
    
    func saveAllSetting(selectAllState: Bool,
                        numberActivities: Float) {
        
        self.updateSelectAllActivities(withState: selectAllState)
        
        if dataList.value != getListActivitySetting() {
            publishIsSettingChanged.onNext(true)
            updateListSettingType(withData: dataList.value)
        }
        
        if numberActivities != getNumberActivities() {
            publishIsSettingChanged.onNext(true)
            updateNumberActivites(withNumber: Int(numberActivities))
        }
    }
}

// MARK: - PRIVATE FUNCTIONS
extension SettingScreenViewModel {
    
    private func loadSettingValues() {
        let listSettingType = getListActivitySetting()
        dataList.accept(listSettingType)
    }
    
    private func getListActivitySetting() -> [ActivitySettingViewModel] {
        return userDefaults.getListActivitySetting()
    }
    
    private func updateSelectAllActivities(withState state: Bool) {
        userDefaults.setSelectAllActivitiesSetting(value: state)
    }
    
    private func updateNumberActivites(withNumber number: Int) {
        userDefaults.setNumberActivitiesSetting(value: number)
    }
    
    private func updateListSettingType(withData listSettingType: [ActivitySettingViewModel]) {
        userDefaults.setListActivitySetting(value: listSettingType)
    }
    
    private func checkUpdateSelectAllSwift(state: Bool, withData listSettingType: [ActivitySettingViewModel]) {
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
