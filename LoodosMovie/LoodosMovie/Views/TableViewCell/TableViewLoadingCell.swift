//
//  TableViewLoadingCell.swift
//  LoodosMovie
//
//  Created by namik kaya on 10.04.2022.
//

import UIKit

class TableViewLoadingCell: UITableViewCell {

    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        indicator.startAnimating()
    }
}
