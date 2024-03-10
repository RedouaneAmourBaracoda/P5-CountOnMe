//
//  Delegate+Extension.swift
//  CountOnMe
//
//  Created by Redouane on 08/03/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension CalculatorManagerDelegate

extension ViewController: CalculatorManagerDelegate {
    func showError(_ error: CalculationError) {
        let alert: UIAlertController = .init(title: "Unvalid operation", message: error.message, preferredStyle: .alert)
        let action: UIAlertAction = .init(title: "ok", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func display(_ result: String) {
        resultTextView.text = result
    }
}
