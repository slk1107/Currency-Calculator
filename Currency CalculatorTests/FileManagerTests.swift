//
//  FileManagerTests.swift
//  Currency CalculatorTests
//
//  Created by Kris on 2020/8/17.
//  Copyright © 2020 KrisLin. All rights reserved.
//

import XCTest
@testable import Currency_Calculator

class FileManagerTests: XCTestCase {
    let fileManager = RateFileManager()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSave() throws {
        let result = fileManager.saveRate(["Test": 0.1])
        assert(result)
    }

    func testRead() {
        guard let fileURL = fileManager.fileURL else {
            return
        }

        let dic = fileManager.readRate()
        if FileManager.default.fileExists(atPath: fileURL.path) {
            assert(dic != nil)
        } else {
            assert(dic == nil)
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
