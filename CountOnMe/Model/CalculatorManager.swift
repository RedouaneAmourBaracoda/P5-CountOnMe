//
//  CalculatorModel.swift
//  CountOnMe
//
//  Created by Redouane on 04/08/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorManagerDelegate: AnyObject {
    func display(_ result: String)
    func showError(_ error: CalculationError)
}

struct CalculatorManager {

    // MARK: - Stored properties

    weak var delegate: CalculatorManagerDelegate?

    private var calculatorModel = CalculatorModel()

    private var stringResult: String = "" {
        didSet {
            delegate?.display(stringResult)
        }
    }

    // MARK: - Methods

    mutating func insert(digit: String) {
        guard !(digit == "0" && stringResult.hasSuffix("/ ")) else { 
            delegate?.showError(CalculationError.divideByZero)
            return
        }

        stringResult += digit
    }

    mutating func insert(operation: String) {
        guard stringResult != "" && stringResult.last != " " else {
            delegate?.showError(CalculationError.unvalidOperator)
            return
        }

        stringResult += " " + operation + " "
        
        if operation == "=" {
            // Number formatter
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = 4
            numberFormatter.locale = Locale.current

            let unformattedResult = calculatorModel.getResult(rawString: stringResult)

            let formattedResult = numberFormatter.string(from: NSDecimalNumber(string: unformattedResult))

            stringResult = formattedResult!
        }
    }
    
    mutating func clear() {
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
