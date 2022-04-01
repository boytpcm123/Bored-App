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
    
    func remove(key: String)
}

struct UserDefaultManager: UserDefaultManagering {
    
    private var userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults.standard
    }
    
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
    
    func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
