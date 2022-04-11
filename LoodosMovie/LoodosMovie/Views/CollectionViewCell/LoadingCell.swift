//
//  LoadingCell.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import UIKit

class LoadingCell: UICollectionViewCell {

    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        indicatorView.startAnimating()
    }
}
