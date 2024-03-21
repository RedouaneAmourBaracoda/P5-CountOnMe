//
//  OperationsTests.swift
//  CountOnMeTests
//
//  Created by Redouane on 14/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

@testable import CountOnMe
import XCTest

final class OperationsTests: XCTestCase {

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
}
