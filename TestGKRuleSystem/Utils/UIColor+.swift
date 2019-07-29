//
//  UIColor+.swift
//  TestGKRuleSystem
//
//  Created by Srikanth KV on 29/07/19.
//  Copyright © 2019 Srikanth KV. All rights reserved.
//

import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
