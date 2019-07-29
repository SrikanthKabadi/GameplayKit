//
//  Fact.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 22/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import Foundation
import GameplayKit

enum ValidationResult {
    case valid
    case invalid(error: FraudError)
}

enum FraudError: Error {
    case notTrustedLocation
    case deviceNotVerified
    case amountNotInThreshold
    case suspiciousTransactionRate
}
