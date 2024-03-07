//
//  CalculatorManagerTests.swift
//  CountOnMeTests
//
//  Created by Redouane on 07/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

@testable import CountOnMe
import XCTest

final class CalculatorManagerTests: XCTestCase {
    var calculatorModel: CalculatorModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.calculatorModel = .init()
    }


    func testStringSeparator() throws {
        let rawString: String = "2 - 1 + 6 x 10 - 4 / 2 = "
        let splitResult = calculatorModel.separateString(rawString: rawString)
        let expectedResult: [Substring] = ["2", "-", "1", "+", "6", "x", "10", "-", "4", "/", "2", "="]
        
        XCTAssertEqual(splitResult, expectedResult)
    }
    
    func testMultiplyStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let mathResult = calculatorModel.multiply(leftOperand, rightOperand)
        let expectedResult: Substring = .init("24")
        XCTAssertEqual(mathResult, expectedResult)
    }
    
    func testDivideStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let mathResult = calculatorModel.divide(leftOperand, rightOperand)
        let expectedResult: Substring = .init("6")
        XCTAssertEqual(mathResult, expectedResult)
    }
    
    func testSimplifyString() {
        let rawString: String = "2 x 3 + 1 - 10 / 5 = "
        let expectedResult: String = "6+1-2="
        let actualResult = calculatorModel.getResult(rawString: rawString)
        XCTAssertEqual(actualResult, expectedResult)
    }
}
