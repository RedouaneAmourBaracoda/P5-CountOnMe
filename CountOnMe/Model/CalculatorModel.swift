//
//  CalculationsManager.swift
//  CountOnMe
//
//  Created by Redouane on 06/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct CalculatorModel {
    private var resultString: [Substring] = []

    mutating func getResult(rawString: String) -> String {
        applyPrioritiesRules(rawString: rawString)
        calculateFinalResult()
        return stringFromSubstring(resultString)
    }
    
    mutating func clear() {
        resultString.removeAll()
    }
    
    private mutating func calculateFinalResult() {
        reduceString(
            condition1: { $0.isAnAddition },
            operation1: add(_:_:),
            condition2: { $0.isASubstraction },
            operation2: substract(_:_:)
        )
        resultString.removeAll { $0.isAnEqualizer }
    }
    
    private mutating func applyPrioritiesRules(rawString: String){
        resultString = separateString(rawString: rawString)
        reduceString(
            condition1: { $0.isAMultiplication },
            operation1: multiply(_:_:),
            condition2: { $0.isADivision },
            operation2: divide(_:_:)
        )
    }

    private mutating func reduceString(
        condition1: (Substring) -> Bool,
        operation1: (Substring, Substring) -> Substring,
        condition2: (Substring) -> Bool,
        operation2: (Substring, Substring) -> Substring
    ){
        guard var lastIndex = resultString.lastIndex(where: { $0.isAnEqualizer }) else { return }
        var index = 0
        while index != lastIndex {
            if condition1(resultString[index]) {
                appendOperation(index: index, operation: operation1)
                lastIndex -= 2
            } else if condition2(resultString[index]) {
                appendOperation(index: index, operation: operation2)
                lastIndex -= 2
            } else {
                index += 1
            }
        }
    }

    private mutating func appendOperation(index: Int, operation: (Substring, Substring) -> Substring) {
        let result = operation(resultString[index - 1], resultString[index + 1])
        resultString[index - 1] = result
        resultString.remove(at: index + 1)
        resultString.remove(at: index)
    }

    private func stringFromSubstring(_ substring: [Substring]) -> String {
        var result: String = ""
        for string in substring {
            result += string
        }
        return result
    }
    
    func add(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Float(leftOperand) ?? 0.0) + (Float(rightOperand) ?? 0.0)
        return Substring(String(mathResult))
    }
    
    func substract(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Float(leftOperand) ?? 0.0) - (Float(rightOperand) ?? 0.0)
        return Substring(String(mathResult))
    }

    func multiply(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Float(leftOperand) ?? 0.0) * (Float(rightOperand) ?? 0.0)
        return Substring(String(mathResult))
    }

    func divide(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Float(leftOperand) ?? 0.0) / (Float(rightOperand) ?? 0.0)
        return Substring(String(mathResult))
    }

    func separateString(rawString: String) -> [Substring] {
        return rawString.split { $0 == " " }
    }
}

private extension Substring {

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
