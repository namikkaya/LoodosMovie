//
//  ToastMessage.swift
//
//  Created by namik kaya on 18.12.2021.
//

import UIKit

class ToastMessage {
    enum ToastMessageType {
        case error, success, warning
        
        var bgColor:UIColor {
            switch self {
            case .error:
                return UIColor.red
            case .success:
                return UIColor.green
            case .warning:
                return UIColor.AppDefaultColor.appYellow.color
            }
        }
        
        var textColor:UIColor {
            switch self {
            case .error:
                return UIColor.white
            case .success:
                return UIColor.white
            case .warning:
                return UIColor.AppDefaultColor.appGrey.color
            }
        }
    }
    
    class private func showAlert(message:String, type: ToastMessageType = .success, delay: TimeInterval = 3.0) {
        if let scene = UIApplication.shared.keyWindow {
            var topSafeAreaHeight:CGFloat = 0
            if #available(iOS 11.0, *) {
                let topPadding = scene.safeAreaInsets.top
                topSafeAreaHeight = topPadding
            }else {
                topSafeAreaHeight = 0
            }
            let estiHeight = estimatedFrame(text: message, font: .systemFont(ofSize: 14), width: scene.frame.size.width).height + (topSafeAreaHeight + 48)
            let toastBar = ToastMessageBarView(frame: CGRect(x: 0, y: 0, width: scene.frame.size.width, height: estiHeight))
            toastBar.setup(message: message)
            toastBar.setTopConstraint = topSafeAreaHeight
            toastBar.frame = CGRect(x: 0, y: 0, width: scene.frame.size.width, height: (topSafeAreaHeight + 48) + toastBar.getHeight)
            
            scene.addSubview(toastBar)
            toastBar.setBackgroundColor = type.bgColor
            toastBar.setTextColor = type.textColor
            toastBar.layer.zPosition = 999
            
            var basketTopFrameCalc:CGRect = toastBar.frame
            basketTopFrameCalc.origin.y -= toastBar.frame.size.height
            toastBar.frame = basketTopFrameCalc
            toastBar.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.10, options: .curveEaseOut) {
                toastBar.frame.origin.y = 0
                toastBar.alpha = 1
            } completion: { act in
                UIView.animate(withDuration: 0.5, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.10, options: .curveEaseIn) {
                    toastBar.frame = basketTopFrameCalc
                    toastBar.alpha = 0
                } completion: { act in
                    toastBar.removeFromSuperview()
                }
            }
        }
    }
    
    class func showToastMessage(message:String, type: ToastMessageType = .success, delay: TimeInterval = 3.0) {
        showAlert(message: message, type: type, delay: delay)
    }
    
    class private func estimatedFrame(text:String, font:UIFont, width: CGFloat) -> CGRect {
        let size = CGSize(width: width - 40, height: 200)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        
    }
}
