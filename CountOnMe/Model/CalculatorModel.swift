//
//  CalculationsManager.swift
//  CountOnMe
//
//  Created by Redouane on 06/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct CalculatorModel {
    mutating func getResult(rawString: String) -> String {
        let substring = simplifyString(rawString: rawString)
        return stringFromSubstring(substring)
    }

    private mutating func simplifyString(rawString: String) -> [Substring]{
        var splittedString = separateString(rawString: rawString)
        guard var lastIndex = splittedString.lastIndex(where: { $0.isAnEqualizer }) else { return [] }
        var index = 0
        while index != lastIndex {
            if splittedString[index].isAMultiplication {
                appendOperation(splittedString: &splittedString, index: index) { multiply($0, $1) }
                lastIndex -= 2
            } else if splittedString[index].isADivision {
                appendOperation(splittedString: &splittedString, index: index) { divide($0, $1) }
                lastIndex -= 2
            } else {
                index += 1
            }
        }
        return splittedString
    }

    private func appendOperation(
        splittedString: inout [Substring],
        index: Int,
        operation: (Substring, Substring) -> Substring
    ) {
        let leftOperand: Substring = splittedString[index - 1]
        let rightOperand: Substring = splittedString[index + 1]
        let result = operation(leftOperand, rightOperand)
        splittedString[index - 1] = result
        splittedString.remove(at: index + 1)
        splittedString.remove(at: index)
    }

    private func stringFromSubstring(_ substring: [Substring]) -> String {
        var result: String = ""
        for string in substring {
            result += string
        }
        return result
    }

    func multiply(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Int(leftOperand) ?? 0) * (Int(rightOperand) ?? 0)
        return Substring(String(mathResult))
    }

    func divide(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Int(leftOperand) ?? 0) / (Int(rightOperand) ?? 0)
        return Substring(String(mathResult))
    }

    func separateString(rawString: String) -> [Substring] {
        return rawString.split { $0 == " " }
    }
}

extension Substring {
    var isAnOperator: Bool {
        isAnAddition || isASubstraction || isAMultiplication || isADivision || isAnEqualizer
    }

    var isAnAddition: Bool {
        (self == "+")
    }

    var isASubstraction: Bool {
        (self == "-")
    }

    var isAMultiplication: Bool {
        (self == "x")
    }

    var isADivision: Bool {
        (self == "/")
    }
    
    var isAnEqualizer: Bool {
        (self == "=")
    }
}
