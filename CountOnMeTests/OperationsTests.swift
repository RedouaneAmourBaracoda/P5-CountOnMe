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
        let mathOperator: MathOperator = .add
        let actualResult = mathOperator.operation(leftOperand, rightOperand)
        let expectedResult = Substring("14.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testSubtractStringOperands() {
        let leftOperand = Substring("12")
        let rightOperand = Substring("2")
        let mathOperator: MathOperator = .substract
        let actualResult = mathOperator.operation(leftOperand, rightOperand)
        let expectedResult = Substring("10.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testMultiplyStringOperands() {
        let leftOperand = Substring("12")
        let rightOperand = Substring("2")
        let mathOperator: MathOperator = .multiply
        let actualResult = mathOperator.operation(leftOperand, rightOperand)
        let expectedResult = Substring("24.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testDivideStringOperands() {
        let leftOperand = Substring("12")
        let rightOperand = Substring("2")
        let mathOperator: MathOperator = .divide
        let actualResult = mathOperator.operation(leftOperand, rightOperand)
        let expectedResult = Substring("6.0")

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testDetectMultiplication() {
        let input: Substring = "x"
        XCTAssertTrue(MathOperator.multiply.isDetectedIn(input))
    }

    func testDetectDivision() {
        let input: Substring = "/"
        XCTAssertTrue(MathOperator.divide.isDetectedIn(input))
    }

    func testDetectAddition() {
        let input: Substring = "+"
        XCTAssertTrue(MathOperator.add.isDetectedIn(input))
    }

    func testDetectSubstraction() {
        let input: Substring = "-"
        XCTAssertTrue(MathOperator.substract.isDetectedIn(input))
    }

    func testDetectEqualizer() {
        let input: Substring = "="
        XCTAssertTrue(input.isAnEqualizer)
    }
}
