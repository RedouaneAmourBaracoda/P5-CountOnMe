//
//  CalculatorManagerTests.swift
//  CountOnMeTests
//
//  Created by Redouane on 07/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

@testable import CountOnMe
import XCTest

final class CalculatorModelTests: XCTestCase {
    var calculatorModel: CalculatorModel!

    override func setUpWithError() throws {
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
        let actualResult = calculatorModel.getSubstringResult()
        let expectedResult: [Substring] = ["2", "-", "1", "+", "60.0", "-", "2.0", "="]

        let prioritiesAreStillLeft: Bool = actualResult.contains {
            MathOperator.multiply.isDetectedIn($0) || MathOperator.divide.isDetectedIn($0)
        }

        XCTAssertFalse(prioritiesAreStillLeft)
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testGetResult() {
        let rawString = "2 x 3 + 1 - 10 / 5 = "
        let expectedResult = "5.0"
        let actualResult = calculatorModel.getResult(rawString: rawString)

        let operatorsAreStillLeft: Bool = calculatorModel.getSubstringResult().contains {
            MathOperator.multiply.isDetectedIn($0)
            || MathOperator.divide.isDetectedIn($0)
            || MathOperator.add.isDetectedIn($0)
            || MathOperator.substract.isDetectedIn($0)
        }

        XCTAssertFalse(operatorsAreStillLeft)
        XCTAssertEqual(actualResult, expectedResult)
    }

    func testClearModel() {
        let rawString = "1 x 5 + 1 - 10 / 5 = "
        var expectedSubstringResult: [Substring] = ["4.0"]
        let expectedStringResult = "4.0"

        XCTAssertEqual(calculatorModel.getResult(rawString: rawString), expectedStringResult)
        XCTAssertEqual(calculatorModel.getSubstringResult(), expectedSubstringResult)

        calculatorModel.clear()
        expectedSubstringResult = []
        XCTAssertEqual(calculatorModel.getSubstringResult(), expectedSubstringResult)
    }
}
