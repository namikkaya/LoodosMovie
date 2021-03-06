//
//  SplashBuilder.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import Foundation

protocol SplashBuilder {
    func build(coordinatorDelegate: CommonControllerToCoordinatorDelegate) -> BaseViewController
}

struct SplashBuilderImpl: SplashBuilder {
    func build(coordinatorDelegate: CommonControllerToCoordinatorDelegate) -> BaseViewController {
        let vc = SplashVC.init(nibName: SplashVC.className, bundle: nil)
        vc.coordinatorDelegate = coordinatorDelegate
        let vm = SplashVM(configService: FirebaseRemoteConfig())
        vc.injectVM(vm: vm)
        return vc
    }
}
