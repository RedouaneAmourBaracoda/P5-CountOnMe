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
    
    var calculatorModel: CalculatorModel?

    // MARK: - View Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculatorModel = CalculatorModel()
        calculatorModel?.delegate = self
    }

    // MARK: - @IBActions

    @IBAction func digitButtonTapped(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        calculatorModel?.addDigit(digit: digit)
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        calculatorModel?.clear()
    }

    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        guard let operation = sender.titleLabel?.text else { return }
        calculatorModel?.addOperation(operation: operation)
    }
}

extension ViewController: CalculatorModelDelegate {
    func showError(_ error: Error) {
        let alert: UIAlertController = .init(title: "\("Unvalid operation")", message: "error.localizedDescription", preferredStyle: .alert)
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

