//
//  ViewController.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 07/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: passwordField.frame.size.height))
            passwordField.leftView = paddingView
            passwordField.leftViewMode = .always
            
            passwordField.layer.cornerRadius = 8.0
            passwordField.layer.borderWidth = 1.0
            passwordField.layer.borderColor = UIColor.black.cgColor
            
            NotificationCenter.default.addObserver(self, selector: #selector(textChanged(notification:))    , name: UITextField.textDidChangeNotification, object: passwordField)
        }
    }
    
    @IBOutlet weak var confirmPasswordField: UITextField! {
        didSet {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: confirmPasswordField.frame.size.height))
            confirmPasswordField.leftView = paddingView
            confirmPasswordField.leftViewMode = .always
            
            confirmPasswordField.layer.cornerRadius = 8.0
            confirmPasswordField.layer.borderWidth = 1.0
            confirmPasswordField.layer.borderColor = UIColor.black.cgColor
            
            NotificationCenter.default.addObserver(self, selector: #selector(textChanged(notification:))    , name: UITextField.textDidChangeNotification, object: confirmPasswordField)
        }
    }
    
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            confirmButton.isEnabled = false
            
            confirmButton.setBackgroundImage(UIColor.purple.image(), for: .normal)
            confirmButton.setBackgroundImage(UIColor.gray.image(), for: .disabled)
            
            confirmButton.layer.cornerRadius = 8
            confirmButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel!
    
    private var password: String = ""
    private var confirmPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        testGKRuleSystem()
        testGKStateMachine()
    }
    
    @objc func textChanged(notification: Notification) {
        let txtField = notification.object as! UITextField
        if txtField == passwordField {
            password = passwordField.text ?? ""
        } else {
            confirmPassword = confirmPasswordField.text ?? ""
        }
        
        let result = PasswordValidator().validatePasswords(password: password, confirmedPassword: confirmPassword)
        switch result {
        case .valid:
            confirmButton.isEnabled = true
            errorLabel.text = nil
            
        case .invalid(let errors):
            confirmButton.isEnabled = false
            
            var errorTxt = "Error: "
            for (index, error) in errors.enumerated() {
                if index != 0 {
                    errorTxt += ", "
                }
                errorTxt += error.rawValue
            }
            
            errorLabel.text = errorTxt
        }
    }
    
    private func testGKRuleSystem() {
        let result = PasswordValidator().validatePasswords(password: "Hell dog", confirmedPassword: "Hell cat")
        print("Result \"\(result)\"")
    }
    
    private func testGKStateMachine() {
        // Create the states
        let green = Green()
        let yellow = Yellow()
        let red = Red()
        
        // Initialize the state machine
        let stateMachine = GKStateMachine(states: [green, yellow, red])
        
        // Try entering various states...
        if stateMachine.enter(Green.self) == false {
            print("failed to move to green")
        }
        
        if stateMachine.enter(Red.self) == false {
            print("failed to move to red")
        }
        
        if stateMachine.enter(Yellow.self) == false {
            print("failed to move to yellow")
        }
        
        if stateMachine.enter(Red.self) == false {
            print("failed to move to Red")
        }
        
        if stateMachine.enter(Green.self) == false {
            print("failed to move to Green")
        }
    }
}

