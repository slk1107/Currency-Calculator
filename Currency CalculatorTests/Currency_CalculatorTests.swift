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
            print(currencies!)
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testFetchExchangeRates() throws {
        let exp = expectation(description: "")

        let task = FetchExchangeRatesTask()

        task.fetch() { exchangeDic in
            assert(exchangeDic != nil)
            print(exchangeDic!)
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
