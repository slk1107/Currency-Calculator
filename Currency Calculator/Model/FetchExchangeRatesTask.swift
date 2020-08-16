//
//  FetchExchangeRatesTask.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation
import Alamofire

class FetchExchangeRatesTask {
    let requestURL = NetworkConstants.Currencylayer.domainURL.appendingPathComponent(NetworkConstants.Currencylayer.API.live)
    let params = [NetworkConstants.Currencylayer.accessKeyKey:
        NetworkConstants.Currencylayer.accessKeyValue]

    func fetch(completeHandler: @escaping (Data?) -> Void) {
        AF.request(requestURL, method: .get, parameters: params).response { response in
            completeHandler(response.data)
        }
    }
}
