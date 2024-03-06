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
