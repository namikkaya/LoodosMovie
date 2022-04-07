//
//  Coordinator.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import UIKit

enum CoordinatorType {
    case app, main
}

protocol Coordinator: NSObject {
    var coordinatorType: CoordinatorType { get set }
    var navigationController: BaseNavigationController { get set }
    var childCoordinator: [Coordinator] { get set }
    func start(completion: @escaping ()->())
    func reset(completion: @escaping () -> ())
    func addChild(coordinator: Coordinator)
    func removeChild(coordinator: Coordinator)
    func finishViewController(controller: UIViewController)
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        childCoordinator.append(coordinator)
    }
    
    func removeChild(coordinator: Coordinator) {
        childCoordinator = childCoordinator.filter({ $0 !== coordinator })
    }
    
    func start(completion: @escaping ()->() = {}) {}
    func reset(completion: @escaping () -> () = {}) {}
}


protocol CommonControllerToCoordinatorDelegate: AnyObject {
    func commonControllerToCoordinator(type: AppFlowEventType)
}

protocol CommonCoordinatorToCoordinatorDelegate: AnyObject {
    func commonCoordinatorToCoordinator(type: CoordinatorEventType)
}
