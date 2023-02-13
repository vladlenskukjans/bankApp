//
//  LocalState.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 13/02/2023.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case hasOnborded
        
    }
    
    public static var hasOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnborded.rawValue)
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnborded.rawValue)
            
        }
    }
    
    
    
    
}
