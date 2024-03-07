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
    private var calculatorModel: CalculatorModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.calculatorModel = .init()
    }

    private func testStringSeparator() throws {
        let rawString: String = "2 - 1 + 6 x 10 - 4 / 2 = "
        let splitResult = calculatorModel.separateString(rawString: rawString)
        let expectedResult: [Substring] = ["2", "-", "1", "+", "6", "x", "10", "-", "4", "/", "2", "="]

        XCTAssertEqual(splitResult, expectedResult)
    }
    
    private func testAddStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let mathResult = calculatorModel.add(leftOperand, rightOperand)
        let expectedResult: Substring = .init("14")

        XCTAssertEqual(mathResult, expectedResult)
    }
    
    private func testSubtractStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let mathResult = calculatorModel.substract(leftOperand, rightOperand)
        let expectedResult: Substring = .init("10")

        XCTAssertEqual(mathResult, expectedResult)
    }

    private func testMultiplyStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let mathResult = calculatorModel.multiply(leftOperand, rightOperand)
        let expectedResult: Substring = .init("24")

        XCTAssertEqual(mathResult, expectedResult)
    }

    private func testDivideStringOperands() {
        let leftOperand: Substring = .init("12")
        let rightOperand: Substring = .init("2")
        let mathResult = calculatorModel.divide(leftOperand, rightOperand)
        let expectedResult: Substring = .init("6")

        XCTAssertEqual(mathResult, expectedResult)
    }

    private func testGetResultFromCalculator() {
        let rawString: String = "2 x 3 + 1 - 10 / 5 = "
        let expectedResult: String = "5"
        let actualResult = calculatorModel.getResult(rawString: rawString)

        XCTAssertEqual(actualResult, expectedResult)
    }
}
