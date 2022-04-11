//
//  NoInternetConnectionVC.swift
//  LoodosMovie
//
//  Created by namik kaya on 11.04.2022.
//

import UIKit
import Lottie

class NoInternetConnectionVC: UIViewController {
    @IBOutlet weak var contentContainer: UIView!{
        didSet {
            contentContainer.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var animationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        playAnimation()
    }

    private func playAnimation() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.8
        animationView.play()
    }
}
