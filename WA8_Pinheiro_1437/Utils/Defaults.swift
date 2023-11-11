//
//  Defaults.swift
//  WA8_Pinheiro_1437
//
//  Created by Lucy Bell on 11/11/23.
//

import Foundation

class Defaults {
    let defaults = UserDefaults.standard
    
    func setKey(key: String? = nil, keyName: String) {
        self.defaults.set(key, forKey: keyName)
    }
    
    func getKey(keyName: String) -> String? {
        return defaults.object(forKey: keyName) as! String?
    }
    
    func deleteKey(keyName: String) {
        self.defaults.removeObject(forKey: keyName)
    }
}
