//
//  DescriptionCell.swift
//  LoodosMovie
//
//  Created by namik kaya on 10.04.2022.
//

import UIKit

class DetailCommonInfoCell: UITableViewCell {

    @IBOutlet private weak var cellTitleLabel: UILabel!
    @IBOutlet private weak var plotDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(title: String, desc: String?) {
        cellTitleLabel.text = title
        plotDescriptionLabel.text = desc
    }
    
}
