//
//  UserDefaultManager.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation
class UserDefaultManager {
    let defaults = UserDefaults.standard

    let fileSavedKey = "FileSaved"

    func saveFileSavedTime(sinceRefereceTime time: TimeInterval) {
        defaults.setValue(time, forKey: fileSavedKey)
    }

    func getFileSavedTime() -> TimeInterval? {
        defaults.double(forKey: fileSavedKey)
    }
}
