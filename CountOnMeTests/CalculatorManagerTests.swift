//
//  ManagerTests.swift
//  CountOnMeTests
//
//  Created by Redouane on 28/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

@testable import CountOnMe
import XCTest

final class CalculatorManagerTests: XCTestCase {
    // Test insert digits.

    func testInsertDigitWhenStringIsEmpty() {
        let inputString = ""
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(digit: "1")
        let expectedString = "1"
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
    }

    func testInsertDigitWhenPreviousCharacterIsDigit() {
        let inputString = "1"
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(digit: "1")
        let expectedString = "11"
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
    }

    func testInsertDigitWhenPreviousCharacterIsOperator() {
        let inputString = "1 + "
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(digit: "1")
        let expectedString = "1 + 1"
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
    }

    func testInsertDigitZeroWhenPreviousCharacterIsDivider() {
        let inputString = "1 / "
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(digit: "0")
        let expectedString = inputString
        let expectedError: CalculationError = .divideByZero
        let expectedErrorMessage = CalculationError.divideByZero.message
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
        XCTAssertEqual(calculatorManager.getCurrentError(), expectedError)
        XCTAssertEqual(calculatorManager.getCurrentError()?.message, expectedErrorMessage)
    }

    func testInsertDigitZeroWhenPreviousCharacterIsNotDivider() {
        let inputString = "1 x "
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(digit: "0")
        let expectedString = "1 x 0"
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
    }

    // Test insert operators.

    func testInsertOperatorWhenPreviousCharacterIsDigit() {
        let inputString = "1"
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(operation: "-")
        let expectedString = "1 - "
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
    }

    func testInsertOperatorWhenStringIsEmpty() {
        let inputString = ""
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(operation: "=")
        let expectedString = inputString
        let expectedError: CalculationError = .invalidOperator
        let expectedErrorMessage = CalculationError.invalidOperator.message
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
        XCTAssertEqual(calculatorManager.getCurrentError(), expectedError)
        XCTAssertEqual(calculatorManager.getCurrentError()?.message, expectedErrorMessage)
    }

    func testInsertOperatorWhenPreviousCharacterIsOperator() {
        let inputString = "1 + "
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(operation: "+")
        let expectedString = inputString
        let expectedError: CalculationError = .invalidOperator
        let expectedErrorMessage = CalculationError.invalidOperator.message
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
        XCTAssertEqual(calculatorManager.getCurrentError(), expectedError)
        XCTAssertEqual(calculatorManager.getCurrentError()?.message, expectedErrorMessage)
    }

    func testInsertEqualOperator() {
        let inputString = "1 + 1 x 2 - 1 / 1"
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.insert(operation: "=")
        let expectedString = "2.0"
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
    }

    func testClearManager() {
        let inputString = "1 + 1 x 2 - 1 / 1"
        var calculatorManager = CalculatorManager(stringResult: inputString)
        calculatorManager.clear()
        let expectedString = ""
        XCTAssertEqual(calculatorManager.getStringResult(), expectedString)
        XCTAssertNil(calculatorManager.getCurrentError())
    }
}
