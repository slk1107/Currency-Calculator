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

    var fileURL: URL? {
        var dic = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        dic?.appendPathComponent(filename)
        return dic
    }

    func saveRate(_ rate: [String: Float]) -> Bool {
        guard let url = fileURL else {
            return false
        }
        let tempDic = NSMutableDictionary(dictionary: rate)
        do {
            try tempDic.write(to: url)
            return true
        } catch {
            return false
        }
    }

    func readRate() -> [String: Float]? {
        guard let url = fileURL else {
            return nil
        }
        if let dictionary = NSMutableDictionary(contentsOf: url) as? [String : Float] {
            return dictionary
        } else {
            return nil
        }
    }

}
