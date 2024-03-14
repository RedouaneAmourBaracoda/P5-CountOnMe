//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class CalculatorViewController: UIViewController {

    // MARK: - @IBOutlets

    @IBOutlet weak var resultTextView: UITextView!

    // MARK: - Stored properties

    private var calculatorManager = CalculatorManager()

    // MARK: - View Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorManager.delegate = self
    }

    // MARK: - @IBActions

    @IBAction func digitButtonTapped(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        calculatorManager.insert(digit: digit)
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        calculatorManager.clear()
    }

    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        guard let operation = sender.titleLabel?.text else { return }
        calculatorManager.insert(operation: operation)
    }
}

// MARK: - Extension CalculatorManagerDelegate

extension CalculatorViewController: CalculatorManagerDelegate {
    func showError(_ error: CalculationError) {
        let alert = UIAlertController(title: "Invalid operation", message: error.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

    func display(_ result: String) {
        resultTextView.text = result
    }
}
