//
//  StringExtensions.swift
//  CountOnMe
//
//  Created by Damien Rivet on 07/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension String.Element {

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
