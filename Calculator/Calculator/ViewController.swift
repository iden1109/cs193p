//
//  ViewController.swift
//  Calculator
//
//  Created by zhengku on 17/01/2017.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTyping : Bool = false
    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        //print("touched \(digit)")
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    var displayValue : Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    var savedProgram : CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }

    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    private var brain : CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathEmaticalSymbol = sender.currentTitle{
            brain.performOperation(mathEmaticalSymbol)
        }
        
        displayValue = brain.result
    }

}

