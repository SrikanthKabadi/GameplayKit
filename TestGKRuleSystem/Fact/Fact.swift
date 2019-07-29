//
//  Fact.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 07/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import Foundation
import GameplayKit

class Fact<T: Error>: NSObject {
    typealias EvaluationBlock = (_ system: GKRuleSystem) -> Bool
    
    let error: T
    let evaluationBlock: EvaluationBlock
    
    init(error: T,
         evaluationBlock: @escaping EvaluationBlock) {
        self.error = error
        self.evaluationBlock = evaluationBlock
    }
}
