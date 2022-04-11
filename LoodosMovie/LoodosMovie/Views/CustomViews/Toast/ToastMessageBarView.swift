//
//  ToastMessageBarView.swift
//
//  Created by namik kaya on 18.12.2021.
//

import UIKit

class ToastMessageBarView: UIView {
    @IBOutlet private weak var contentContainer: UIView!
    @IBOutlet private weak var content: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var topSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bgColorView: UIView! {
        didSet {
            bgColorView.layer.cornerRadius = 10
            bgColorView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 0, blur: 6, spread: 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nibLoad()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.nibLoad()
    }
    
    private func nibLoad() {
        self.contentContainer = self.loadNib()
        self.contentContainer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(contentContainer)
        self.contentContainer.layoutIfNeeded()
        messageLabel.textColor = setTextColor
        bgColorView.backgroundColor = setBackgroundColor
    }
    
    func setup(message: String?) {
        messageLabel.text = message
        
    }
    
    var getHeight: CGFloat {
        get {
            return estimatedFrame(text: messageLabel.text ?? "" , font: .systemFont(ofSize: 14)).height
        }
    }
    
    var setTopConstraint:CGFloat = 0 {
        didSet {
            topSafeAreaConstraint.constant = setTopConstraint
        }
    }
    
    var setBackgroundColor:UIColor = .red {
        didSet {
            bgColorView.backgroundColor = setBackgroundColor
        }
    }
    
    var setTextColor: UIColor = .white {
        didSet {
            messageLabel.textColor = setTextColor
        }
    }
    
    func estimatedFrame(text:String, font:UIFont) -> CGRect {
        let size = CGSize(width: self.frame.size.width - 20, height: 200)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        
    }
}
