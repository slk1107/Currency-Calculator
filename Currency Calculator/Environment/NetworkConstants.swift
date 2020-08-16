//
//  NetworkConstants.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation

struct NetworkConstants {
    struct Currencylayer {
        static let domain = "http://api.currencylayer.com"
        static let accessKeyKey = "access_key"
        static let accessKeyValue = "73c6bad2797ef52b1800c2c043f15a47"
    }
}

extension NetworkConstants.Currencylayer {
    static var domainURL = URL(string: domain)!
}
