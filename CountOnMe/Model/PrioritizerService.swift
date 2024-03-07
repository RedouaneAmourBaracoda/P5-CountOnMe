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
    
    mutating func prioritizeString(rawString: String) -> String {
        for character in rawString {
            character.isAnOperator ? fillOperator(with: character) : fillOperands(with: character)
        }
        return resultString
    }

    private mutating func fillOperator(with operation: String.Element) {
        if (operation == "x") {
            if isMultiplicationFlagRaised {
                leftOperand = String((Int(leftOperand) ?? 0) * (Int(rightOperand) ?? 0))
                rightOperand.removeAll()
            }
            isMultiplicationFlagRaised = true
        } else {
            if !isMultiplicationFlagRaised {
                resultString.append(leftOperand)
                resultString.append(operation)
                leftOperand.removeAll()
            } else {
                leftOperand = String((Int(leftOperand) ?? 0) * (Int(rightOperand) ?? 0))
                resultString.append(leftOperand)
                resultString.append(operation)
                leftOperand.removeAll()
                rightOperand.removeAll()
                isMultiplicationFlagRaised = false
            }
        }
    }

    private mutating func fillOperands(with digit: String.Element){
        if !isMultiplicationFlagRaised {
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
