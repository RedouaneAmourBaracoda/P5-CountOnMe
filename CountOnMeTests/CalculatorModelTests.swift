//
//  CalculatorManagerTests.swift
//  CountOnMeTests
//
//  Created by Redouane on 07/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

@testable import CountOnMe
import XCTest

typealias Operations =  CalculatorModel.MathOperator

final class CalculatorManagerTests: XCTestCase {
    var calculatorModel: CalculatorModel!
    let numberFormatter: NumberFormatter = .init()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.calculatorModel = .init()
        numberFormatter.locale = .current
        numberFormatter.decimalSeparator = "."
        numberFormatter.minimumFractionDigits = 4
    }

    func testStringSeparator() throws {
        let rawString: String = "2 - 1 + 6 x 10 - 4 / 2 = "
        let actualResult = calculatorModel.testSeparateStrings(rawString: rawString)
        let expectedResult: [Substring] = ["2", "-", "1", "+", "6", "x", "10", "-", "4", "/", "2", "="]

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testAddStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let actualResult = Operations.add(leftOperand, rightOperand)
        let expectedResult: Substring = .init("14.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testSubtractStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let actualResult = Operations.substract(leftOperand, rightOperand)
        let expectedResult: Substring = .init("10.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testMultiplyStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let actualResult = Operations.multiply(leftOperand, rightOperand)
        let expectedResult: Substring = .init("24.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testDivideStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let actualResult = Operations.divide(leftOperand, rightOperand)
        let expectedResult: Substring = .init("6.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testGetResultFromCalculator() {
        let rawString: String = "2 x 3 + 1 - 10 / 5 = "
        let expectedResult: String = "5.0"
        let actualResult = calculatorModel.getResult(rawString: rawString)

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testGetResultFromCalculatorWithFormattedDecimalNumber() {
        let rawString: String = "4 / 3 - 1 = "
        let expectedResult: String = "0.3333"

        let unformattedResult = calculatorModel.getResult(rawString: rawString)
        guard let formattedResult = numberFormatter.string(from: NSDecimalNumber(string: unformattedResult)) else {
            return
        }
        
        XCTAssertEqual(formattedResult, expectedResult)
    }

    func testGetResultFromCalculatorWithNonFormattedDecimalNumber() {
        let rawString: String = "4 / 3 - 1 = "
        let expectedResult: String = "0.3333"

        let unformattedResult = calculatorModel.getResult(rawString: rawString)
        
        XCTAssertNotEqual(unformattedResult, expectedResult)
    }
}
