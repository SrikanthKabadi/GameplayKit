//
//  FraudValidator.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 22/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import Foundation
import GameplayKit

class FruadValidator {
    
    // add this function within password validator class
    func validateFraud() -> ValidationResult {
        // create the facts
        let facts = [locationFact,
                     deviceVerificationFact,
                     amountThresholdFact,
                     transactionRateFact]
        
        /* create rule system and provide all the facts
         which we want to evaluate */
        let ruleSystem = GKRuleSystem()
        ruleSystem.add(facts.map(FactRule.init))
        
        // add the state to the rule system
        ruleSystem.state["location"] = data.locationInfo
        ruleSystem.state["deviceInfo"] = data.deviceInfo
        ruleSystem.state["amountInfo"] = data.amountInfo
        ruleSystem.state["transactionRate"] = data.transactionRate
        
        // evaluate
        ruleSystem.evaluate()
        
        // extract the errors from the facts created by the evaluation
        let erroredFacts = facts.filter {
            ruleSystem.grade(forFact: $0) == 0
        }
        
        let errors = erroredFacts.map { $0.error }
        
        let error = errors.first
        if let error = error {
            return .invalid(error: error)
        } else {
            return .valid
        }
    }
    
    private let locationFact = Fact(error: .notTrustedLocation) {
        (system: GKRuleSystem) in
        // get location info from system.state
        // return true or false upon evaluation
    }
    
    private let deviceVerificationFact = Fact(error: .deviceNotVerified) {
        system in
        // get deviceInfo from system.state
        // return true or false upon evaluation
    }
    
    private let amountThresholdFact = Fact(error: .amountNotInThreshold) {
        system in
        // get amountInfo from system.state
        // return true or false upon evaluation
    }
    
    private let transactionRateFact = Fact(error: .suspiciousTransactionRate) {
        system in
        // get transactionRate info from system.state
        // return true or false upon evaluation
    }
}
