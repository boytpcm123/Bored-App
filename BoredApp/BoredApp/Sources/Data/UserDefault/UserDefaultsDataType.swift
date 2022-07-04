//
//  UserDefaultsDataType.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/25/22.
//

enum UserDefaultsDataType {

    case nightMode
    case numberActivities
    case selectAllActivities
    case listSettingType

    func key() -> String {
        switch self {
        case .nightMode:
            return "kNightModeKey"
        case .numberActivities:
            return "kNumberActivitiesKey"
        case .selectAllActivities:
            return "kSelectAllActivitiesKey"
        case .listSettingType:
            return "kListSettingTypeKey"
        }
    }

    func defaultValue() -> Any? {
        switch self {
        case .nightMode:
            return false
        case .numberActivities:
            return 5
        case .selectAllActivities:
            return true
        case .listSettingType:
            return nil
        }
    }
}
