//
//  SplashVC.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import UIKit
import Lottie

class SplashVC: BaseViewController {
    private var vm: SplashVM!
    
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var configLabel: UILabel! {
        didSet {
            configLabel.isHidden = true
        }
    }
    
    private var pendingConfigWorkItem: DispatchWorkItem?
    
    private var configStr: String? {
        didSet {
            if let configStr = configStr {
                configLabel.text = configStr
                cameraAnimationPlay()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observer()
        vm.start()
        cameraAnimationPlay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recursiveCheckConfig(delay: 3)
    }
    
    func injectVM(vm: SplashVM) {
        self.vm = vm
    }

}

extension SplashVC {
    private func observer() {
        vm.stateClosure = { [weak self] type in
            switch type {
            case .updateUI(let data):
                self?.updateUI(type: data)
                break
            case .error(_):
                
                break
            }
        }
    }
    
    private func updateUI(type: SplashVM.SplashObservation?) {
        guard let type = type else { return }
        switch type {
        case .configSuccess(let title):
            self.configStr = title
        }
    }
}

extension SplashVC {
    /// If config is loaded,  navigation after the first 3 seconds.
    /// - Parameter delay: default 0.3
    private func recursiveCheckConfig(delay: Double = 0.3) {
        pendingConfigWorkItem?.cancel()
        pendingConfigWorkItem = nil
        pendingConfigWorkItem = DispatchWorkItem { [weak self] in
            self?.pendingConfigWorkItem?.cancel()
            self?.pendingConfigWorkItem = nil
            if self?.configStr != nil {
                DispatchQueue.main.async {
                    self?.splashAnimation()
                }
            }else {
                self?.recursiveCheckConfig()
            }
        }
        guard let pendingConfigWorkItem = pendingConfigWorkItem else { return }
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delay, execute: pendingConfigWorkItem)
    }

    private func splashAnimation() {
        configLabel.alpha = 0
        configLabel.isHidden = false
        
        configLabel.transform = CGAffineTransform(translationX: 0, y: 40)
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.configLabel.alpha = 1
            self?.configLabel.transform = .identity
        }
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(0.20),
                       options: UIView.AnimationOptions.allowUserInteraction) { [weak self] in
            self?.animationView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { act in
            
            UIView.animate(withDuration: 0.8) { [weak self] in
                self?.animationView.transform = CGAffineTransform(scaleX: 5, y: 5)
            }
            
            self.coordinatorDelegate?.commonControllerToCoordinator(type: .app(flowType: .goToMain))
        }

    }
}

extension SplashVC {
    private func cameraAnimationPlay() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.8
        animationView.play()
    }
}
