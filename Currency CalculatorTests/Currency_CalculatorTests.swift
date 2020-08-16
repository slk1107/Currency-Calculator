//
//  Currency_CalculatorTests.swift
//  Currency CalculatorTests
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import XCTest
@testable import Currency_Calculator

class APITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetwrokConstants() throws {
        _ = NetworkConstants.Currencylayer.domainURL
    }

    func testFetchCurrencies() throws {
        let exp = expectation(description: "")

        let task = FetchCurrenciesTask()

        task.fetch() { currencies in
            assert(currencies != nil)
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testFetchExchangeRates() throws {
        let exp = expectation(description: "")

        let task = FetchExchangeRatesTask()

        task.fetch() { data in
            assert(data != nil)

            if let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
            } else {
                assertionFailure("data encode fail")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
