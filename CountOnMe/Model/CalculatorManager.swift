//
//  CalculatorModel.swift
//  CountOnMe
//
//  Created by Redouane on 04/08/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation
import OSLog

protocol CalculatorManagerDelegate: AnyObject {
    func display(_ result: String)
    func showError(_ error: CalculationError)
}

struct CalculatorManager {

    // MARK: - Stored properties

    weak var delegate: CalculatorManagerDelegate?

    private var calculatorModel = CalculatorModel()

    private var stringResult: String {
        didSet {
            currentError = nil
            delegate?.display(stringResult)
        }
    }

    private var currentError: CalculationError? {
        didSet {
            guard let currentError else { return }
            delegate?.showError(currentError)
        }
    }

    init(stringResult: String = "") {
        self.stringResult = stringResult
    }

    // MARK: - Methods

    mutating func insert(digit: String) {
        guard !(digit == "0" && stringResult.hasSuffix("/ ")) else {
            currentError = .divideByZero
            return
        }
        stringResult += digit
    }

    mutating func insert(operation: String) {
        guard stringResult != "" && stringResult.last != " " else {
            currentError = .invalidOperator
            return
        }

        stringResult += " " + operation + " "
        if operation == "=" {
            stringResult = calculatorModel.getResult(rawString: stringResult)
            print("string result : \(stringResult)")
        }
    }

    mutating func clear() {
        stringResult = ""
        currentError = nil
        calculatorModel.clear()
    }
}

enum CalculationError: Error {
    case invalidOperator
    case divideByZero

    var message: String {
        switch self {
        case .invalidOperator:
            "invalid operator"
        case .divideByZero:
            "division by 0"
        }
    }
}

// Test private properties.
extension CalculatorManager {

    func getStringResult() -> String {
        self.stringResult
    }

    func getCurrentError() -> CalculationError? {
        self.currentError
    }
}
