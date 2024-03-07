//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit


final class ViewController: UIViewController {

    // MARK: - @IBOutlets

    @IBOutlet weak var resultTextView: UITextView!

    // MARK: - Stored properties

    private var calculatorManager: CalculatorManager?

    // MARK: - View Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculatorManager = CalculatorManager()
        calculatorManager?.delegate = self
    }

    // MARK: - @IBActions

    @IBAction func digitButtonTapped(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        calculatorManager?.insert(digit: digit)
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        calculatorManager?.clear()
    }

    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        guard let operation = sender.titleLabel?.text else { return }
        calculatorManager?.insert(operation: operation)
    }
}

// MARK: - Extension CalculatorManagerDelegate

extension ViewController: CalculatorManagerDelegate {
    func showError(_ error: CalculationError) {
        let alert: UIAlertController = .init(title: "Unvalid operation", message: error.message, preferredStyle: .alert)
        let action: UIAlertAction = .init(title: "ok", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func display(_ result: String) {
        self.resultTextView.text = result
    }
}

