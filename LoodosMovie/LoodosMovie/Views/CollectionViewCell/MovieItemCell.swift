//
//  MovieItemCell.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import UIKit

class MovieItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var labelBg: UIView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.cancelDownload()
        posterImageView.preparePlaceHolder()
        posterImageView.image = nil
        self.labelBg.clearGradient()
    }
    
    func setup(data: MovieItemModel) {
        posterImageView.load(path: data.Poster ?? "", contentMode: .scaleAspectFill)
        movieNameLabel.text = data.Title
        yearLabel.text = data.Year
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.labelBg.setGradientBackground(colors: [
            UIColor.AppDefaultColor.appGrey.color.withAlphaComponent(0.7).cgColor,
            UIColor.AppDefaultColor.appGrey.color.withAlphaComponent(1).cgColor
        ], locations: [
            0.0, 1.0
        ])
    }
}

