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
        clearGradient()
    }
    
    func setup(data: MovieItemModel) {
        posterImageView.load(path: data.Poster ?? "", contentMode: .scaleAspectFill)
        movieNameLabel.text = data.Title
        yearLabel.text = data.Year
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }

    
    func setGradientBackground() {
        clearGradient()
        let colorTop = UIColor.AppDefaultColor.appGrey.color.withAlphaComponent(0.7).cgColor
        let colorBottom = UIColor.AppDefaultColor.appGrey.color.withAlphaComponent(1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.labelBg.bounds
        gradientLayer.name = "gradient"
        self.labelBg.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func clearGradient() {
        if let sublayers = labelBg.layer.sublayers {
            for layer in sublayers {
                if layer.name == "gradient" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}

