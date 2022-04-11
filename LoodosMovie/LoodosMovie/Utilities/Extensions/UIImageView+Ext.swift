//
//  UIImageView+Ext.swift
//  LoodosMovie
//
//  Created by namik kaya on 8.04.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(path: String?, placeHolder: UIImage? = UIImage(named: "placeHolder"), contentMode: UIView.ContentMode = .scaleAspectFit) {
        kf.setImage(with: URL(string: path ?? ""), placeholder: placeHolder, options: [.cacheMemoryOnly]) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.contentMode = .center
            case .success:
                self.contentMode = contentMode
            }
        }

    }
    
    func cancelDownload() {
        kf.cancelDownloadTask()
    }
    
    func preparePlaceHolder(img: UIImage? = UIImage(named: "placeHolder")) {
        self.image = img
        self.contentMode = .scaleAspectFit
    }
}
