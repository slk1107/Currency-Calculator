//
//  FetchExchangeRatesTask.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation
import Alamofire

struct ExchangeRatesResponse: Decodable {
    let source: String
    let quotes: [String: Float]

    var exchangeDic: [String: Float] {
        var newDic = [String: Float]()
        for (key, value) in quotes {
            guard let newKey = key.components(separatedBy: source).last else {
                newDic[key] = value
                continue
            }

            if key == "\(source)\(source)" {
                newDic[source] = value
                continue
            }

            newDic[newKey] = value
        }
        return newDic
    }
}

class FetchExchangeRatesTask {
    let requestURL = NetworkConstants.Currencylayer.domainURL.appendingPathComponent(NetworkConstants.Currencylayer.API.live)
    let params = [NetworkConstants.Currencylayer.accessKeyKey:
        NetworkConstants.Currencylayer.accessKeyValue]

    func fetch(completeHandler: @escaping ([String: Float]?) -> Void) {
        AF.request(requestURL, method: .get, parameters: params).response { response in
            guard let data = response.data,
                let result = try? JSONDecoder().decode(ExchangeRatesResponse.self, from: data) else {
                completeHandler(nil)
                return
            }
            completeHandler(result.exchangeDic)
        }
    }
}
