//
//  CalculationsManager.swift
//  CountOnMe
//
//  Created by Redouane on 06/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct CalculatorModel {

    // MARK: - Stored properties

    private var substringResult: [Substring] = []

    // MARK: - Methods

    mutating func getResult(rawString: String) -> String {
        applyPriorityRules(rawString: rawString)
        addAndSubstractOperands()
        return stringFromSubstring(substringResult)
    }

    private mutating func applyPriorityRules(rawString: String) {
        substringResult = separateString(rawString: rawString)
        detectOperators(.multiply, .divide)
    }

    private mutating func addAndSubstractOperands() {
        detectOperators(.add, .substract)
        substringResult.removeAll { $0.isAnEqualizer }
    }

    private func separateString(rawString: String) -> [Substring] {
        return rawString.split { $0 == " " }
    }

    private mutating func detectOperators(_ mathOperator1: MathOperator, _ mathOperator2: MathOperator) {
        guard var lastIndex = substringResult.lastIndex(where: { $0.isAnEqualizer }) else { return }
        var index = 0
        while index != lastIndex {
            if mathOperator1.isDetectedIn(substringResult[index]) {
                calculateAndReplace(index: index, operation: mathOperator1.operation)
                lastIndex -= 2
            } else if mathOperator2.isDetectedIn(substringResult[index]) {
                calculateAndReplace(index: index, operation: mathOperator2.operation)
                lastIndex -= 2
            } else {
                index += 1
            }
        }
    }

    private mutating func calculateAndReplace(index: Int, operation: (Substring, Substring) -> Substring) {
        let result = operation(substringResult[index - 1], substringResult[index + 1])
        substringResult[index - 1] = result
        substringResult.remove(at: index + 1)
        substringResult.remove(at: index)
    }

    private func stringFromSubstring(_ substring: [Substring]) -> String {
        var result = ""
        for string in substring {
            result += string
        }
        return result
    }

    mutating func clear() {
        substringResult.removeAll()
    }
}

// Test private methods.
extension CalculatorModel {
    func testSeparateStrings(rawString: String) -> [Substring] {
        self.separateString(rawString: rawString)
    }

    mutating func testApplyPriorityRules(rawString: String) {
        self.applyPriorityRules(rawString: rawString)
    }

    func getSubstringResult() -> [Substring] {
        self.substringResult
    }
}
