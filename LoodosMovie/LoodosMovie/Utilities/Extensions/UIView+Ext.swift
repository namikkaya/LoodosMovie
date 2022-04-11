//
//  UIView+Ext.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import UIKit

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    static func fromNib<T : UIView>() -> T {
        let nibName = String.init(describing: self)
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0] as! T
    }
    
    class func instance<T : UIView>() -> T {
        return self.fromNib()
    }
    
    static var view: UIView? {
        return Bundle.main.loadNibNamed(className, owner: nil, options: nil)?[0] as? UIView
    }
    
    static var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }
}

extension UIView {
    func setGradientBackground(colors: [CGColor], locations: [NSNumber]?) {
        clearGradient()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.frame = self.bounds
        gradientLayer.name = "gradient"
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func clearGradient() {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if layer.name == "gradient" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}
