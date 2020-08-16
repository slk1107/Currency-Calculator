//
//  RateFileManager.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation
class RateFileManager {
    let filename = "rate.cache"
    func save(rate: [String: Float]) -> Bool {
        guard var directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return false
        }
        directory.appendPathComponent(filename)
        let tempDic = NSMutableDictionary(dictionary: rate)
        do {
            try tempDic.write(to: directory)
            return true
        } catch {
            return false
        }
    }
}
