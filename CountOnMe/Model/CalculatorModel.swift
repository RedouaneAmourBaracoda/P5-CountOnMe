//
//  CalculationsManager.swift
//  CountOnMe
//
//  Created by Redouane on 06/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct CalculatorModel {
    private var leftOperand: String = ""
    private var rightOperand: String = ""
    private var currentOperator: MathOperation?

    mutating func getResult(rawString: String) -> String {
        var substring = rawString
        substring.removeAll { $0 == " " }
        
        for character in substring {
            character.isAnOperator ? fillOperator(with: character) : fillOperands(with: character)
        }
        let finalResult = leftOperand
        clearOperandsAndOperators()
        return finalResult
    }

    mutating func clear() {
        clearOperandsAndOperators()
    }

    private mutating func fillOperator(with operation: String.Element) {
        calculateFormerOperation()
        fillNewOperator(with: operation)
    }

    private mutating func calculateFormerOperation(){
        guard let currentOperator else { return }
        switch currentOperator {
        case .addition:
            leftOperand = add(leftOperand: leftOperand, rightOperand: rightOperand)
        case .substraction:
            leftOperand = substract(leftOperand: leftOperand, rightOperand: rightOperand)
        }
        rightOperand.removeAll()
    }

    private mutating func fillNewOperator(with character: String.Element) {
        if (character == "+") {
            currentOperator = .addition
        } else if (character == "-"){
            currentOperator = .substraction
        }
    }

    private mutating func clearOperandsAndOperators() {
        leftOperand.removeAll()
        currentOperator = nil
    }

    private mutating func fillOperands(with digit: String.Element){
        if currentOperator == nil {
            leftOperand.append(digit)
        } else {
            rightOperand.append(digit)
        }
    }

    private func add(leftOperand: String, rightOperand: String) -> String {
        String((Int(leftOperand) ?? 0) + (Int(rightOperand) ?? 0))
    }

    private func substract(leftOperand: String, rightOperand: String) -> String {
        String((Int(leftOperand) ?? 0) - (Int(rightOperand) ?? 0))
    }
}

private enum MathOperation {
    case addition
    case substraction
}


private extension String.Element {
    var isAnOperator: Bool {
        (self == "+") || (self == "-") || (self == "*") || (self == "/") || (self == "=")
    }
}
