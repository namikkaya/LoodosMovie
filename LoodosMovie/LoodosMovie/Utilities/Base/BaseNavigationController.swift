//
//  BaseNavigationController.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import UIKit

class BaseNavigationController: UINavigationController {
    weak var coordinatorDelegate: CommonControllerToCoordinatorDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.isTranslucent = true
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.shadowImage = UIImage()
            appearance.backgroundColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
