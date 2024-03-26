//
//  NumberFormatter+Extension.swift
//  CountOnMe
//
//  Created by Redouane on 14/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static let shared: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.minimumSignificantDigits = 1
        formatter.decimalSeparator = "."
        return formatter
    }()
}
