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

    // MARK: - Methods
    mutating func add(digit: String){
        guard !(digit == "0" && stringResult.hasSuffix("/ ")) else { delegate?.showError(CalculationError.divideByZero)
            return
        }
        stringResult += digit
    }

    mutating func add(operation: String) {
        guard stringResult != "" && stringResult.last != " " else {
            delegate?.showError(CalculationError.unvalidOperator)
            return
        }
        stringResult += " " + operation + " "
        if operation == "=" {
            getResult()
        }
    }

    private mutating func getResult() {
        var substring = stringResult
        substring.removeAll { $0 == " " }
        
        for character in substring {
            character.isAnOperator ? fillOperator(with: character) : fillOperands(with: character)
        }
        stringResult = leftOperand
        clearOperandsAndOperators()
    }

    private mutating func fillOperator(with character: String.Element) {
        calculateFormerOperation()
        fillNewOperator(with: character)
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
