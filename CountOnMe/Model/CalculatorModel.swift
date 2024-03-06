//
//  CalculatorModel.swift
//  CountOnMe
//
//  Created by Redouane on 04/08/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorModelDelegate {
    func display(_ result: String)
    func showError(_ error: CalculationError)
}

struct CalculatorModel {

    // MARK: - Stored properties
    var delegate: CalculatorModelDelegate?
    private var stringResult: String = "" {
        didSet {
            delegate?.display(stringResult)
        }
    }

    private var leftOperand: String?

    // MARK: - Computed properties
    private var canAddOperation: Bool {
        stringResult != "" && stringResult.last != " "
    }

    // MARK: - Methods
    mutating func addDigit(digit: String){
        guard !(digit == "0" && stringResult.hasSuffix("/ ")) else { delegate?.showError(CalculationError.divideByZero)
            return
        }
        stringResult += digit
    }

    mutating func addOperation(operation: String) {
        guard canAddOperation else {
            delegate?.showError(CalculationError.unvalidOperator)
            return
        }
        stringResult += " " + operation + " "
    }

    mutating func makeCalculation() {
        guard canAddOperation else {
            delegate?.showError(CalculationError.unvalidOperator)
            return
        }
        stringResult += " " + "=" + " "
        getMathResult()
    }
    
    private mutating func getMathResult() {
        var substring = "+" + stringResult
        substring.removeAll { $0 == " " }
        
        var leftOperand: String = ""
        var rightOperand: String = ""
        var currentOperator: MathOperation?
        for character in substring {
            if (character != "+") && (character != "=") {
                if currentOperator == nil {
                    leftOperand.append(character)
                } else {
                    rightOperand.append(character)
                }
            } else {
                if rightOperand.isEmpty {
                    currentOperator = .addition
                } else {
                    leftOperand = addition(leftOperand: leftOperand, rightOperand: rightOperand)
                    rightOperand.removeAll()
                }
            }
        }
        stringResult = leftOperand
    }
    
    private func addition(leftOperand: String, rightOperand: String) -> String {
        String((Int(leftOperand) ?? 0) + (Int(rightOperand) ?? 0))
    }

    mutating func clear() {
        stringResult = ""
    }
}

enum MathOperation {
    case addition
}

enum CurrentOperand {
    case left
    case right
}

enum CalculationError: Error {
    case unvalidOperator
    case divideByZero
    
    var message: String {
        switch self {
        case .unvalidOperator:
            "unvalid operator"
        case .divideByZero:
            "division by 0"
        }
    }
}
