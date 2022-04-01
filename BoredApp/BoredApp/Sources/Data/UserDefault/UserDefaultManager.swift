//
//  UserDefaultManager.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/1/22.
//

import Foundation

protocol UserDefaultManagering {
    func getNightModeSetting() -> Bool
    func setNightModeSetting(value: Bool)
    
    func getSelectAllActivitiesSetting() -> Bool
    func setSelectAllActivitiesSetting(value: Bool)
    
    func getNumberActivitiesSetting() -> Int
    func setNumberActivitiesSetting(value: Int)
    
    func getListActivitySetting() -> [ActivitySettingViewModel]
    func setListActivitySetting(value: [ActivitySettingViewModel])
}

struct UserDefaultManager: UserDefaultManagering {
    
    private var userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults.standard
    }
}

// MARK: - PUBLIC FUNCTIONS
extension UserDefaultManager {
    
    func getNightModeSetting() -> Bool {
        return self.getBool(key: Constants.nightMode) ?? Constants.initNightMode
    }
    
    func setNightModeSetting(value: Bool) {
        self.setBool(key: Constants.nightMode, value: value)
    }
    
    func getSelectAllActivitiesSetting() -> Bool {
        return self.getBool(key: Constants.selectAllActivities) ?? Constants.initSelectAllActivities
    }
    
    func setSelectAllActivitiesSetting(value: Bool) {
        self.setBool(key: Constants.selectAllActivities, value: value)
    }
    
    func getNumberActivitiesSetting() -> Int {
        return self.getInt(key: Constants.numberActivities) ?? Constants.initNumActivities
    }
    
    func setNumberActivitiesSetting(value: Int) {
        self.setInt(key: Constants.numberActivities, value: value)
    }
    
    func getListActivitySetting() -> [ActivitySettingViewModel] {
        if let listSettingType = getObject(forKey: Constants.listSettingType,
                                           castTo: Array<ActivitySettingViewModel>.self) {
            return listSettingType
        }
        
        return ActivityType.allCases.map { ActivitySettingViewModel(activityType: $0) }
    }
    
    func setListActivitySetting(value: [ActivitySettingViewModel]) {
        self.setObject(value, forKey: Constants.listSettingType)
    }
    
}

// MARK: - SUPPORT FUNCTIONS
extension UserDefaultManager {
    
    fileprivate func getString(key: String) -> String {
        userDefaults.string(forKey: key) ?? ""
    }
    
    fileprivate func setString(key: String, value: String) {
        userDefaults.set(value, forKey: key)
    }
    
    fileprivate func getBool(key: String) -> Bool? {
        if let value = userDefaults.value(forKey: key) {
            return value as? Bool
        }
        return nil
    }
    
    fileprivate func setBool(key: String, value: Bool) {
        userDefaults.set(value, forKey: key)
    }
    
    fileprivate func getInt(key: String) -> Int? {
        if let value = userDefaults.value(forKey: key) {
            return value as? Int
        }
        return nil
    }
    
    fileprivate func setInt(key: String, value: Int) {
        userDefaults.set(value, forKey: key)
    }
    
    fileprivate func setObject<Object>(_ object: Object, forKey: String) where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: forKey)
            userDefaults.synchronize()
        } catch {
            print("Failed to encode object:", error.localizedDescription)
        }
    }
    
    fileprivate func getObject<Object>(forKey: String, castTo type: Object.Type) -> Object? where Object: Decodable {
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
    
    fileprivate func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
