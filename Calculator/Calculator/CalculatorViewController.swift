//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Angus on 2022/4/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    
    private var calculateString: String = "0"
    private var numberOperator: String = ""
    private var firstNumber: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        addChildren()
        boardVC.label.text = calculateString
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.delegate = self
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.topAnchor.constraint(equalTo: boardVC.view.bottomAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            keyboardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
        ])
    }
    
}

extension CalculatorViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(viewController: KeyboardViewController, didTapKey letter: Character) {
        
        switch letter {
        case "➗":
            numberOperator = "div"
            firstNumber = Double(calculateString)!
            calculateString = ""
        case "✖️":
            numberOperator = "mul"
            firstNumber = Double(calculateString)!
            calculateString = ""
        case "➖":
            numberOperator = "min"
            firstNumber = Double(calculateString)!
            calculateString = ""
        case "➕":
            numberOperator = "add"
            firstNumber = Double(calculateString)!
            calculateString = ""
        case "!":
            var sum = 1
            
            for i in sum...Int(calculateString)! {
                sum *= i
            }
            
            calculateString = String(sum)
            boardVC.label.text = calculateString
        case "C":
            calculateString = "0"
            firstNumber = 0
            boardVC.label.text = calculateString
        case "N":
            if calculateString.contains("-") {
                calculateString = String(calculateString.dropFirst())
                boardVC.label.text = calculateString
            } else {
                calculateString = "-" + calculateString
                boardVC.label.text = calculateString
            }
        case ".":
            if calculateString.contains(".") {
                return
            } else {
                calculateString.append(".")
                boardVC.label.text = calculateString
            }
        case "=":
            switch numberOperator {
            case "div":
                firstNumber /= Double(calculateString)!
                boardVC.label.text = String(firstNumber)
            case "mul":
                firstNumber *= Double(calculateString)!
                boardVC.label.text = String(firstNumber)
            case "min":
                firstNumber -= Double(calculateString)!
                boardVC.label.text = String(firstNumber)
            case "add":
                firstNumber += Double(calculateString)!
                boardVC.label.text = String(firstNumber)
            default:
                if firstNumber == 0.0 {
                    boardVC.label.text = calculateString
                } else {
                    boardVC.label.text = String(firstNumber)
                }
            }
        case " ":
            return
        default:
            if calculateString.first == "0" && !calculateString.contains(".") {
                calculateString = String(letter)
                boardVC.label.text = calculateString
            } else {
                calculateString.append(String(letter))
                boardVC.label.text = calculateString
            }
        }
        
    }
    
}
