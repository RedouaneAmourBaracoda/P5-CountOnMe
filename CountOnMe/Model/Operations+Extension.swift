//
//  CalculatorModel+Extension.swift
//  CountOnMe
//
//  Created by Redouane on 08/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

// Operations
extension CalculatorModel {
    
    func add(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Float(leftOperand) ?? 0.0) + (Float(rightOperand) ?? 0.0)
        return Substring(String(mathResult))
    }

    func substract(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Float(leftOperand) ?? 0.0) - (Float(rightOperand) ?? 0.0)
        print("Soustraction: \(leftOperand) - \(rightOperand) = \(mathResult)")
        return Substring(String(mathResult))
    }

    func multiply(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Float(leftOperand) ?? 0.0) * (Float(rightOperand) ?? 0.0)
        return Substring(String(mathResult))
    }

    func divide(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
        let mathResult = (Float(leftOperand) ?? 0.0) / (Float(rightOperand) ?? 0.0)
        print("Division: \(leftOperand) / \(rightOperand) = \(mathResult)")
        return Substring(String(mathResult))
    }
}

extension Substring {

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
