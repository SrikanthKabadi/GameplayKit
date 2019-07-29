//
//  PasswordValidators.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 07/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import Foundation
import GameplayKit

enum PasswordError: String, Error {
    case passwordsDontMatch = "passwords don't match"
    case notLongEnough = "should have atleast 8 characters"
    case uppercaseMissing = "should have atleast 1 uppercase character"
    case lowerCaseMissing = "should have atleast 1 lowercase character"
    case noNumbers = "should have numbers"
    case spacesNotAllowed = "spaces are not allowed"
}

class PasswordValidator {
    
    // add this function within password validator class
    func validatePasswords(password: String,
                           confirmedPassword: String) -> ValidationResult {
        // create the facts
        let facts = [lengthFact,
                     uppercaseLetterFact,
                     lowercaseLetterFact,
                     numberFact,
                     noWhiteSpaceFact,
                     passwordsMatchFact]
        
        // add other rules here
        
        /* create rule system and provide all the facts
         which we want to evaluate */
        let ruleSystem = GKRuleSystem()
        ruleSystem.add(facts.map(FactRule.init))
        
        // add the state to the rule system
        ruleSystem.state["password"] = password
        ruleSystem.state["confirmedPassword"] = confirmedPassword
        
        // evaluate
        ruleSystem.evaluate()
        
        // extract the errors from the facts created by the evaluation
        let erroredFacts = facts.filter {
            ruleSystem.grade(forFact: $0) == 0
        }
        
        let errors = erroredFacts.map { $0.error }
        if !errors.isEmpty {
            return .invalid(errors: errors)
        } else {
            return .valid
        }
    }
    
    private let lengthFact = Fact(error: PasswordError.notLongEnough) {
        (system: GKRuleSystem) in
        
        guard let password = system.state["password"] as? String,
            password.count >= 8 else {
                return false
        }
        
        return true
    }
    
    private let passwordsMatchFact = Fact(error: PasswordError.passwordsDontMatch) {
        system in
        guard let password = system.state["password"] as? String,
            let confirmedPass = system.state["confirmedPassword"] as? String,
            password == confirmedPass else {
                return false
        }
        return true
    }
    
    private let uppercaseLetterFact = Fact(error: PasswordError.uppercaseMissing) {
        system in
        guard let password = system.state["password"] as? String,
            password.rangeOfCharacter(from: .uppercaseLetters) != nil else {
                return false
        }
        return true
    }
    
    private let lowercaseLetterFact = Fact(error: PasswordError.lowerCaseMissing) {
        system in
        guard let password = system.state["password"] as? String,
            password.rangeOfCharacter(from: .lowercaseLetters) != nil else {
                return false
        }
        return true
    }
    
    private let numberFact = Fact(error: PasswordError.noNumbers) {
        system in
        guard let password = system.state["password"] as? String,
            password.rangeOfCharacter(from: .decimalDigits) != nil else {
                return false
        }
        return true
    }
    
    private let noWhiteSpaceFact = Fact(error: PasswordError.spacesNotAllowed) {
        system in
        guard let password = system.state["password"] as? String,
            password.rangeOfCharacter(from: .whitespacesAndNewlines) == nil else {
                return false
        }
        return true
    }
}

class ValidatePassword {
    private func lengthCheck(password: String?) -> Bool {
        guard let password = password, password.count >= 8 else {
            return false
        }
        
        return true
    }
    
    private func checkForPasswordsMatch(password: String?, confirmPassword: String?) -> Bool {
        guard let password = password, let confirmedPass = confirmPassword,
            password == confirmedPass else {
                return false
        }
        
        return true
    }
    
    private func checkForUpperCase(password: String?) -> Bool {
        guard let password = password,
            password.rangeOfCharacter(from: .uppercaseLetters) != nil else {
                return false
        }
        
        return true
    }
    
    // add different checks here
}
