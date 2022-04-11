//
//  AppCoordinator.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import UIKit

protocol AppCoordinatoring:Coordinator {
    func goToMainFlow()
}

class AppCoordinator: NSObject, AppCoordinatoring {
    var coordinatorType: CoordinatorType = .app
    var navigationController: BaseNavigationController
    var childCoordinator: [Coordinator] = []
    
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SplashBuilderImpl().build(coordinatorDelegate: self)
        self.navigationController.viewControllers = [vc]
    }
    
    func goToMainFlow() {
        let coordinator = MainCoordinator(parentNavigationViewController: self.navigationController)
        coordinator.delegate = self
        self.addChild(coordinator: coordinator)
        coordinator.start()
    }
    
    func reset(completion: @escaping () -> ()) {
        if let vc = self.navigationController.presentedViewController {
            vc.dismiss(animated: false)
        }
        childCoordinator.forEach { item in
            item.reset { }
            item.navigationController.viewControllers.removeAll()
            self.removeChild(coordinator: item)
        }
        completion()
    }
}

extension AppCoordinator: CommonControllerToCoordinatorDelegate {
    func commonControllerToCoordinator(type: AppFlowEventType) {
        switch type {
        case .app(let flowType):
            switch flowType {
            case .goToMain:
                goToMainFlow()
            }
            break
        default : break
        }
    }
}

extension AppCoordinator: CommonCoordinatorToCoordinatorDelegate {
    func commonCoordinatorToCoordinator(type: CoordinatorEventType) {
        switch type {
        case .finishCoordinator(let coordinator):
            coordinator.reset {
                self.removeChild(coordinator: coordinator)
            }
        }
    }
}
