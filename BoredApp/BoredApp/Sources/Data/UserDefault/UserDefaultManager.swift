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
        return self.getBool(key: Constants.UserDefaultsKey.nightMode) ?? Constants.initNightMode
    }
    
    func setNightModeSetting(value: Bool) {
        self.setBool(key: Constants.UserDefaultsKey.nightMode, value: value)
    }
    
    func getSelectAllActivitiesSetting() -> Bool {
        return self.getBool(key: Constants.UserDefaultsKey.selectAllActivities) ?? Constants.initSelectAllActivities
    }
    
    func setSelectAllActivitiesSetting(value: Bool) {
        self.setBool(key: Constants.UserDefaultsKey.selectAllActivities, value: value)
    }
    
    func getNumberActivitiesSetting() -> Int {
        return self.getInt(key: Constants.UserDefaultsKey.numberActivities) ?? Constants.initNumActivities
    }
    
    func setNumberActivitiesSetting(value: Int) {
        self.setInt(key: Constants.UserDefaultsKey.numberActivities, value: value)
    }
    
    func getListActivitySetting() -> [ActivitySettingViewModel] {
        if let listSettingType = getObject(forKey: Constants.UserDefaultsKey.listSettingType,
                                           castTo: Array<ActivitySettingViewModel>.self) {
            return listSettingType
        }
        
        return ActivityType.allCases.map { ActivitySettingViewModel(activityType: $0) }
    }
    
    func setListActivitySetting(value: [ActivitySettingViewModel]) {
        self.setObject(value, forKey: Constants.UserDefaultsKey.listSettingType)
    }
    
}

// MARK: - SUPPORT FUNCTIONS
extension UserDefaultManager {
    
    private func getString(key: String) -> String {
        userDefaults.string(forKey: key) ?? ""
    }
    
    private func setString(key: String, value: String) {
        userDefaults.set(value, forKey: key)
    }
    
    private func getBool(key: String) -> Bool? {
        if let value = userDefaults.value(forKey: key) {
            return value as? Bool
        }
        return nil
    }
    
    private func setBool(key: String, value: Bool) {
        userDefaults.set(value, forKey: key)
    }
    
    private func getInt(key: String) -> Int? {
        if let value = userDefaults.value(forKey: key) {
            return value as? Int
        }
        return nil
    }
    
    private func setInt(key: String, value: Int) {
        userDefaults.set(value, forKey: key)
    }
    
    private func setObject<Object>(_ object: Object, forKey: String) where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: forKey)
            userDefaults.synchronize()
        } catch {
            print("Failed to encode object:", error.localizedDescription)
        }
    }
    
    private func getObject<Object>(forKey: String, castTo type: Object.Type) -> Object? where Object: Decodable {
        guard let data = userDefaults.data(forKey: forKey) else { return nil }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            print("Failed to decode object:", error.localizedDescription)
            return nil
        }
    }
    
    private func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
