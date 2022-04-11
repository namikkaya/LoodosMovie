//
//  StretchyTableHeaderView.swift
//  LoodosMovie
//
//  Created by namik kaya on 10.04.2022.
//

import UIKit

class StretchyTableHeaderView: UIView {
    @IBOutlet private weak var contentContainer: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var imageViewBottom: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var effectView: UIView!
    @IBOutlet private weak var imdbRatingView: ImdbRatingView! {
        didSet {
            imdbRatingView.isHidden = true
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.effectView.setGradientBackground(colors: [
            UIColor.AppDefaultColor.appGrey.color.withAlphaComponent(0).cgColor,
            UIColor.AppDefaultColor.appGrey.color.withAlphaComponent(0.8).cgColor,
            UIColor.AppDefaultColor.appGrey.color.withAlphaComponent(1).cgColor
        ], locations: [
            0.0, 0.8, 1.0
        ])
    }
    
    func setup(detail: MovieDetails?) {
        guard let detail = detail else { return }
        posterImageView.load(path: detail.Poster ?? "", contentMode: .scaleAspectFill)
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        setRating(ratings: detail.Ratings)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        contentContainer.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    private func setRating(ratings: [MovieRatingItem]?) {
        imdbRatingView.isHidden = true
        if let ratings = ratings {
            ratings.forEach({ item in
                if item.Source == RatingType.imdb.name {
                    if let value = item.Value {
                        imdbRatingView.setup(rating: value)
                        imdbRatingView.isHidden = false
                    }
                }
            })
        }else {
            imdbRatingView.isHidden = true
        }
    }
}

extension StretchyTableHeaderView{
    enum RatingType {
        case imdb
        case rotten
        case metaCritic
        
        var name: String {
            switch self {
            case .imdb: return "Internet Movie Database"
            case .rotten: return "Rotten Tomatoes"
            case .metaCritic: return "Metacritic"
            }
        }
    }
}
