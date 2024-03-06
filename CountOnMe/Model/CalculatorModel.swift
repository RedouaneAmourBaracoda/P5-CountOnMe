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

    private var leftOperand: String = ""
    private var rightOperand: String = ""
    private var currentOperator: MathOperation?

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
        var substring = stringResult
        substring.removeAll { $0 == " " }
        
        for character in substring {
            if (character != "+") && (character != "=") && (character != "-") {
                fillOperands(with: character)
            } else {
                if rightOperand.isEmpty {
                    if (character == "+") {
                        currentOperator = .addition
                    } else {
                        currentOperator = .substraction
                    }
                } else {
                    switch currentOperator {
                    case .addition:
                        leftOperand = add(leftOperand: leftOperand, rightOperand: rightOperand)
                    case .substraction:
                        leftOperand = substract(leftOperand: leftOperand, rightOperand: rightOperand)
                    case nil:
                        break
                    }
                    rightOperand.removeAll()
                    if (character == "+") {
                        currentOperator = .addition
                    } else if (character == "-"){
                        currentOperator = .substraction
                    } else {
                        currentOperator = nil
                    }
                }
            }
        }
        stringResult = leftOperand
        leftOperand.removeAll()
    }
    
    private mutating func fillOperands(with character: String.Element){
        if currentOperator == nil {
            leftOperand.append(character)
        } else {
            rightOperand.append(character)
        }
    }
    
    private func add(leftOperand: String, rightOperand: String) -> String {
        String((Int(leftOperand) ?? 0) + (Int(rightOperand) ?? 0))
    }

    private func substract(leftOperand: String, rightOperand: String) -> String {
        String((Int(leftOperand) ?? 0) - (Int(rightOperand) ?? 0))
    }

    mutating func clear() {
        stringResult = ""
        currentOperator = nil
        leftOperand.removeAll()
        rightOperand.removeAll()
    }
}

enum MathOperation {
    case addition
    case substraction
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

private extension String.Element {
    var isAnOperator: Bool {
        (self == "+") || (self == "-") || (self == "*") || (self == "/") || (self == "=")
    }
}
