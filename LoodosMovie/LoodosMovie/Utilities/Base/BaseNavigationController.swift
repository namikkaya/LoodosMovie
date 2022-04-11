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
        
    }

}
