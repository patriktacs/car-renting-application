//
//  PersistencyManager.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation

protocol PersistingManager {
    func setData<T>(set data: T, forKey key: String)
    func getString(forKey key: String) -> String
    func getBool(forKey key: String) -> Bool
    func removeData(forKey key: String)
}

class PersistencyManager: PersistingManager {
    let userDefaults = UserDefaults.standard
    
    func setData<T>(set data: T, forKey key: String) {
        switch data {
        case is String, is Bool:
            userDefaults.set(data, forKey: key)
        default:
            return
        }
    }
    
    func getString(forKey key: String) -> String {
        return userDefaults.string(forKey: key) ?? ""
    }
    
    func getBool(forKey key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }
    
    func removeData(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
