//
//  InitState.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 22/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import Foundation
import GameKit

class InitState: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == PendingState.Type ||
            stateClass == FailedState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
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
        ruleSystem.state["locationInfo"] = data.locationInfo
        ruleSystem.state["deviceInfo"] = data.deviceInfo
        ruleSystem.state["amountInfo"] = data.amountInfo
        ruleSystem.state["transactionRate"] = data.transactionRate
        
        // evaluate
        ruleSystem.evaluate()
        
        // extract the errors from the facts created by the evaluation
        let erroredFacts = facts.filter {
            ruleSystem.grade(forFact: $0) == 0
        }
        
        stateMachine?.enter(erroredFacts.count > 0 ? FailedState.self : PendingState.self)
        if erroredFacts.count > 0 {
            stateMachine?.enter(FailedState.self)
        } else {
            stateMachine?.enter(PendingState.self)
        }
    }
}
