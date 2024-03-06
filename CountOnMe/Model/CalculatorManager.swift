//
//  CalculatorModel.swift
//  CountOnMe
//
//  Created by Redouane on 04/08/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorManagerDelegate {
    func display(_ result: String)
    func showError(_ error: CalculationError)
}

struct CalculatorManager {

    // MARK: - Stored properties
    var delegate: CalculatorManagerDelegate?
    private var stringResult: String = "" {
        didSet {
            delegate?.display(stringResult)
        }
    }
    
    private var calculatorModel: CalculatorModel = .init()

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
            stringResult = calculatorModel.getResult(rawString: stringResult)
        }
    }
    
    mutating func clear(){
        stringResult = ""
        calculatorModel.clear()
    }
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
