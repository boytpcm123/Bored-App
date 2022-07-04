//
//  UserDefaultManager.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/1/22.
//

import Foundation

protocol UserDefaultManagerProtocol {
    func getNightModeSetting() -> Bool
    func setNightModeSetting(value: Bool)
    
    func getSelectAllActivitiesSetting() -> Bool
    func setSelectAllActivitiesSetting(value: Bool)
    
    func getNumberActivitiesSetting() -> Int
    func setNumberActivitiesSetting(value: Int)
    
    func getListActivitySetting() -> [ActivitySettingViewModel]
    func setListActivitySetting(value: [ActivitySettingViewModel])
}

struct UserDefaultManager: UserDefaultManagerProtocol {
    
    private var userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults.standard
    }
}

// MARK: - PUBLIC FUNCTIONS
extension UserDefaultManager {
    
    func getNightModeSetting() -> Bool {
        return self.getBool(dataType: .nightMode)
    }
    
    func setNightModeSetting(value: Bool) {
        self.setBool(dataType: .nightMode, value: value)
    }
    
    func getSelectAllActivitiesSetting() -> Bool {
        return self.getBool(dataType: .selectAllActivities)
    }
    
    func setSelectAllActivitiesSetting(value: Bool) {
        self.setBool(dataType: .selectAllActivities, value: value)
    }
    
    func getNumberActivitiesSetting() -> Int {
        return self.getInt(dataType: .numberActivities)
    }
    
    func setNumberActivitiesSetting(value: Int) {
        self.setInt(dataType: .numberActivities, value: value)
    }
    
    func getListActivitySetting() -> [ActivitySettingViewModel] {
        if let listSettingType = getObject(dataType: .listSettingType,
                                           castTo: Array<ActivitySettingViewModel>.self) {
            return listSettingType
        }
        
        return ActivityType.allCases.map { ActivitySettingViewModel(activityType: $0) }
    }
    
    func setListActivitySetting(value: [ActivitySettingViewModel]) {
        self.setObject(dataType: .listSettingType, object: value)
    }
    
}

// MARK: - SUPPORT FUNCTIONS
extension UserDefaultManager {
    
    private func getString(dataType: UserDefaultsDataType) -> String {
        userDefaults.string(forKey: dataType.key()) ?? ""
    }
    
    private func setString(dataType: UserDefaultsDataType, value: String) {
        userDefaults.set(value, forKey: dataType.key())
    }

    private func getBool(dataType: UserDefaultsDataType) -> Bool {
        if let value = userDefaults.value(forKey: dataType.key()) {
            return value as? Bool ?? false
        }

        return dataType.defaultValue() as? Bool ?? false
    }
    
    private func setBool(dataType: UserDefaultsDataType, value: Bool) {
        userDefaults.set(value, forKey: dataType.key())
    }
    
    private func getInt(dataType: UserDefaultsDataType) -> Int {
        if let value = userDefaults.value(forKey: dataType.key()) {
            return value as? Int ?? 0
        }
        return dataType.defaultValue() as? Int ?? 0
    }
    
    private func setInt(dataType: UserDefaultsDataType, value: Int) {
        userDefaults.set(value, forKey: dataType.key())
    }
    
    private func setObject<Object>(dataType: UserDefaultsDataType, object: Object) where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: dataType.key())
            userDefaults.synchronize()
        } catch {
            print("Failed to encode object:", error.localizedDescription)
        }
    }
    
    private func getObject<Object>(dataType: UserDefaultsDataType, castTo type: Object.Type) -> Object? where Object: Decodable {
        guard let data = userDefaults.data(forKey: dataType.key()) else { return nil }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            print("Failed to decode object:", error.localizedDescription)
            return nil
        }
    }
    
    private func remove(dataType: UserDefaultsDataType) {
        userDefaults.removeObject(forKey: dataType.key())
    }
}
