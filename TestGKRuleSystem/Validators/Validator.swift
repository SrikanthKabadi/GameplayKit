//
//  Validator.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 07/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import Foundation

enum ValidationResult {
    case valid
    case invalid(errors: [PasswordError])
}
