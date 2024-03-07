//
//  PrioritizerService.swift
//  CountOnMe
//
//  Created by Redouane on 07/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

public struct PrioritizerService {
    private var leftOperand: String = ""
    private var rightOperand: String = ""
    private var resultString: String = ""
    private var isMultiplicationFlagRaised: Bool = false
    private var isDivisionFlagRaised: Bool = false
    
    mutating func prioritizeString(rawString: String) -> String {
        for character in rawString {
            character.isAnOperator ? fillOperator(with: character) : fillOperands(with: character)
        }
        return resultString
    }

    private mutating func fillOperator(with operation: String.Element) {
        if operation.isAMultiplication {
            if isMultiplicationFlagRaised {
                leftOperand = String((Int(leftOperand) ?? 0) * (Int(rightOperand) ?? 0))
                rightOperand.removeAll()
            }
            if isDivisionFlagRaised {
                leftOperand = String((Int(leftOperand) ?? 0) / (Int(rightOperand) ?? 0))
                rightOperand.removeAll()
                isDivisionFlagRaised = false
            }
            isMultiplicationFlagRaised = true
        } else if operation.isADivision {
            if isDivisionFlagRaised {
                leftOperand = String((Int(leftOperand) ?? 0) / (Int(rightOperand) ?? 0))
                rightOperand.removeAll()
            }
            if isMultiplicationFlagRaised {
                leftOperand = String((Int(leftOperand) ?? 0) * (Int(rightOperand) ?? 0))
                rightOperand.removeAll()
                isMultiplicationFlagRaised = false
            }
            isDivisionFlagRaised = true
        } else {
            if isMultiplicationFlagRaised {
                leftOperand = String((Int(leftOperand) ?? 0) * (Int(rightOperand) ?? 0))
                resultString.append(leftOperand)
                resultString.append(operation)
                leftOperand.removeAll()
                rightOperand.removeAll()
                isMultiplicationFlagRaised = false
            } else if isDivisionFlagRaised {
                leftOperand = String((Int(leftOperand) ?? 0) / (Int(rightOperand) ?? 0))
                resultString.append(leftOperand)
                resultString.append(operation)
                leftOperand.removeAll()
                rightOperand.removeAll()
                isDivisionFlagRaised = false
            } else {
                resultString.append(leftOperand)
                resultString.append(operation)
                leftOperand.removeAll()
            }
        }
    }

    private mutating func fillOperands(with digit: String.Element){
        if !isMultiplicationFlagRaised && !isDivisionFlagRaised {
            leftOperand.append(digit)
        } else {
            rightOperand.append(digit)
        }
    }

    mutating func clear() {
        resultString.removeAll()
        leftOperand.removeAll()
        rightOperand.removeAll()
        isMultiplicationFlagRaised = false
    }
}
