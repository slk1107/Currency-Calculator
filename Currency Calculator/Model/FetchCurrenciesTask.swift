//
//  FetchCurrenciesTask.swift
//  Currency Calculator
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import Foundation
import Alamofire

class FetchCurrenciesTask {
    let requestURL = NetworkConstants.Currencylayer.domainURL.appendingPathComponent("live")
    let params = [NetworkConstants.Currencylayer.accessKeyKey:
        NetworkConstants.Currencylayer.accessKeyValue]

    func fetch(completeHandler: @escaping (Data?) -> Void) {
        AF.request(requestURL, method: .get, parameters: params).response { response in
            completeHandler(response.data)
            print("response: \(response.request)")
        }
    }
}
