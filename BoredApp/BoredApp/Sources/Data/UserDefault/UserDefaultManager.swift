//
//  UserDefaultManager.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/1/22.
//

import Foundation

protocol UserDefaultManagering {
    func getString(key: String) -> String
    func setString(key: String, value: String)
    
    func getBool(key: String) -> Bool?
    func setBool(key: String, value: Bool)
    
    func getInt(key: String) -> Int?
    func setInt(key: String, value: Int)
    
    func getListActivitySetting() -> [ActivitySettingViewModel]
    func setListActivitySetting(value: [ActivitySettingViewModel])
    
    func remove(key: String)
}

struct UserDefaultManager: UserDefaultManagering {
    
    private var userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults.standard
    }
}

// MARK: - PUBLIC FUNCTIONS
extension UserDefaultManager {
    
    func getString(key: String) -> String {
        userDefaults.string(forKey: key) ?? ""
    }
    
    func setString(key: String, value: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func getBool(key: String) -> Bool? {
        if let value = userDefaults.value(forKey: key) {
            return value as? Bool
        }
        return nil
    }
    
    func setBool(key: String, value: Bool) {
        userDefaults.set(value, forKey: key)
    }
    
    func getInt(key: String) -> Int? {
        if let value = userDefaults.value(forKey: key) {
            return value as? Int
        }
        return nil
    }
    
    func setInt(key: String, value: Int) {
        userDefaults.set(value, forKey: key)
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
    
    func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}

// MARK: - SUPPORT FUNCTIONS
extension UserDefaultManager {
    
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
}
