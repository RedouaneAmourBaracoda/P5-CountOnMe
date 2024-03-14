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
        let rawString = "2 - 1 + 6 x 10 - 4 / 2 = "
        let actualResult = calculatorModel.testSeparateStrings(rawString: rawString)
        let expectedResult: [Substring] = ["2", "-", "1", "+", "6", "x", "10", "-", "4", "/", "2", "="]

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testRemovePrioritiesFromString() throws {
        let rawString = "2 - 1 + 6 x 10 - 4 / 2 = "
        calculatorModel.testApplyPriorityRules(rawString: rawString)
        let expectedResult: [Substring] = ["2", "-", "1", "+", "60.0", "-", "2.0", "="]

        XCTAssertEqual(calculatorModel.getStringResult(), expectedResult)
    }

    func testAddStringOperands() {
        let leftOperand = Substring("12")
        let rightOperand = Substring("2")
        let actualResult = MathOperator.add(leftOperand, rightOperand)
        let expectedResult = Substring("14.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testSubtractStringOperands() {
        let leftOperand = Substring("12")
        let rightOperand = Substring("2")
        let actualResult = MathOperator.substract(leftOperand, rightOperand)
        let expectedResult = Substring("10.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testMultiplyStringOperands() {
        let leftOperand = Substring("12")
        let rightOperand = Substring("2")
        let actualResult = MathOperator.multiply(leftOperand, rightOperand)
        let expectedResult = Substring("24.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testDivideStringOperands() {
        let leftOperand = Substring("12")
        let rightOperand = Substring("2")
        let actualResult = MathOperator.divide(leftOperand, rightOperand)
        let expectedResult = Substring("6.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testGetResultFromCalculator() {
        let rawString = "2 x 3 + 1 - 10 / 5 = "
        let expectedResult = "5.0"
        let actualResult = calculatorModel.getResult(rawString: rawString)

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testGetResultFromCalculatorWithFormattedDecimalNumber() {
        let rawString = "4 / 3 - 1 = "
        let expectedResult = "0.3333"

        let unformattedResult = calculatorModel.getResult(rawString: rawString)
        guard let formattedResult = NumberFormatter.shared.string(from: NSDecimalNumber(string: unformattedResult)) else {
            XCTFail("Formatting has failed.")
            return
        }

        XCTAssertEqual(formattedResult, expectedResult)
    }

    func testGetResultFromCalculatorWithNonFormattedDecimalNumber() {
        let rawString = "4 / 3 - 1 = "
        let expectedResult = "0.3333"

        let unformattedResult = calculatorModel.getResult(rawString: rawString)

        XCTAssertNotEqual(unformattedResult, expectedResult)
    }
}
