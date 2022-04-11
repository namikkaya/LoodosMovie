//
//  ImdbRatingView.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import UIKit

class ImdbRatingView: UIView {
    
    
    @IBOutlet var contentContainer: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
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
    }
    
    func setup(rating: String) {
        ratingLabel.text = rating
    }
    
}
