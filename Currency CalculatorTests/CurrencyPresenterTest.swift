//
//  CurrencyPresenterTest.swift
//  Currency CalculatorTests
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import XCTest
@testable import Currency_Calculator

class CurrencyPresenterTest: XCTestCase {
    var exp: XCTestExpectation?
    let presenter = CurrencyPresenter()

    override func setUpWithError() throws {
        exp = expectation(description: "")
        presenter.view = self

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() throws {
        presenter.viewDidLoad()
        waitForExpectations(timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension CurrencyPresenterTest: CurrencyViewControllerUseCase {
    func updateCurrencyPicker() {

    }

    func updateCurrencyButton(title: String) {

    }

    func updateTextField(number: Float) {
        
    }

    func updateExchangeRatesTableView() {
        assert(presenter.changeRateResults != nil)
        exp?.fulfill()
    }

    func updatePicker() {
        assert(presenter.currencies != nil)
        exp?.fulfill()
    }

    
}
