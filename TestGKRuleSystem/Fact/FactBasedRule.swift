//
//  FactBasedRule.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 07/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import Foundation
import GameplayKit

class FactRule<T: Error>: GKRule {
    let fact: Fact<T>
    
    init(fact: Fact<T>) {
        self.fact = fact
        super.init()
    }
    
    override func evaluatePredicate(in system: GKRuleSystem) -> Bool {
        return fact.evaluationBlock(system)
    }
    
    override func performAction(in system: GKRuleSystem) {
        system.assertFact(fact)
    }
}
