//
//  UIColor+ext.swift
//  LoodosMovie
//
//  Created by namik kaya on 8.04.2022.
//

import UIKit

extension UIColor{
    enum AppDefaultColor: String {
        case appGrey,
             appYellow
        
        var color: UIColor {
            switch self {
            default: return UIColor(named: self.rawValue)!
            }
        }
    }
}
