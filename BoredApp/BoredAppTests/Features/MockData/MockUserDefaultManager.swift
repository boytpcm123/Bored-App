//
//  MockUserDefaultManager.swift
//  BoredAppTests
//
//  Created by hungdat1234 on 4/7/22.
//

import Foundation
@testable import BoredApp

struct MockUserDefaultManager: UserDefaultManagerProtocol {

    func getNightModeSetting() -> Bool {
        return true
    }

    func setNightModeSetting(value: Bool) {

    }

    func getSelectAllActivitiesSetting() -> Bool {
        return false
    }

    func setSelectAllActivitiesSetting(value: Bool) {

    }

    func getNumberActivitiesSetting() -> Int {
        return 1
    }

    func setNumberActivitiesSetting(value: Int) {

    }

    func getListActivitySetting() -> [ActivitySettingViewModel] {
        return []
    }

    func setListActivitySetting(value: [ActivitySettingViewModel]) {

    }
}
