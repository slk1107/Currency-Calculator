//
//  FetchCurrenciesTask.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation
import Alamofire

struct CurrenciesResponse: Codable {
    let currencies: [String: String]?
}

struct Currency {
    let key: String
    let name: String
}

class FetchCurrenciesTask {
    let requestURL = NetworkConstants.Currencylayer.domainURL.appendingPathComponent(NetworkConstants.Currencylayer.API.list)
    let params = [NetworkConstants.Currencylayer.accessKeyKey:
        NetworkConstants.Currencylayer.accessKeyValue]

    func fetch(completeHandler: @escaping ([Currency]?) -> Void) {
        AF.request(requestURL, method: .get, parameters: params).response { response in
            guard let data = response.data,
                let result = try? JSONDecoder().decode(CurrenciesResponse.self, from: data),
                let currencies = result.currencies else {
                completeHandler(nil)
                return
            }
            let results = currencies.map { Currency(key: $0.key, name: $0.value) }
            completeHandler(results)
        }
    }
}
