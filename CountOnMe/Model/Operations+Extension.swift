//
//  CalculatorModel+Extension.swift
//  CountOnMe
//
//  Created by Redouane on 08/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension CalculatorModel {
    
    enum MathOperator {
        case add
        case substract
        case multiply
        case divide

        var isDetectedIn: (Substring) -> Bool {
            switch self {
            case .add:
                return { $0.isAnAddition }
            case .substract:
                return { $0.isASubstraction }
            case .multiply:
                return { $0.isAMultiplication }
            case .divide:
                return { $0.isADivision }
            }
        }

        var operation: (Substring, Substring) -> Substring {
            switch self {
            case .add:
                return Self.add(_:_:)
            case .substract:
                return Self.substract(_:_:)
            case .multiply:
                return Self.multiply(_:_:)
            case .divide:
                return Self.divide(_:_:)
            }
        }

        static func add(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
            let mathResult = (Float(leftOperand) ?? 0.0) + (Float(rightOperand) ?? 0.0)
            return Substring(String(mathResult))
        }

        static func substract(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
            let mathResult = (Float(leftOperand) ?? 0.0) - (Float(rightOperand) ?? 0.0)
            return Substring(String(mathResult))
        }

        static func multiply(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
            let mathResult = (Float(leftOperand) ?? 0.0) * (Float(rightOperand) ?? 0.0)
            return Substring(String(mathResult))
        }

        static func divide(_ leftOperand: Substring, _ rightOperand: Substring) -> Substring {
            let mathResult = (Float(leftOperand) ?? 0.0) / (Float(rightOperand) ?? 0.0)
            return Substring(String(mathResult))
        }
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
