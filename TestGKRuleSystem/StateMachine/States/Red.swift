//
//  Red.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 08/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import Foundation
import GameKit

class Red: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Yellow.Type
    }
    
    override func didEnter(from previousState: GKState?) {
    }
    
    override func willExit(to nextState: GKState) {
    }
}
