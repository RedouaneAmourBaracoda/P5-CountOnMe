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
    func showError(_ error: Error)
}

struct CalculatorModel {
    
    // MARK: - Stored properties
    var delegate: CalculatorModelDelegate?
    private var operation: String = ""
    private var stringResult: String = "" {
        didSet {
            delegate?.display(stringResult)
        }
    }

    // MARK: - Computed properties
    private var canAddOperation: Bool {
        stringResult != "" && stringResult.last != " "
    }
    
    // MARK: - Methods
    mutating func addDigit(digit: String){
        stringResult += digit
    }

    mutating func addOperation(operation: String) {
        if canAddOperation {
            if operation == "=" {
                stringResult += " " + operation + " "
                let finalResult: Double = calculateResult(stringResult)
            } else {
                stringResult += " " + operation + " "
            }
        } else {
            delegate?.showError(CalculationError.unvalidOperator)
        }
    }

    mutating func clear() {
        stringResult = ""
    }
    
    private func calculateResult(_ stringResult: String) -> Double {
        let table = stringResult
            .map { $0 }
            .filter({ $0 != " "})

        for element in table {
            print(element)
        }
        return 0
    }
}

enum CalculationError: Error {
    case unvalidOperator
}
