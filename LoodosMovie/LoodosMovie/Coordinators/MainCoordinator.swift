//
//  MainCoordinator.swift
//  LoodosMovie
//
//  Created by namik kaya on 8.04.2022.
//

import UIKit

protocol MainCoordinatoring: Coordinator {
    var parentNavigationViewController: BaseNavigationController { get set }
    init(parentNavigationViewController: BaseNavigationController)
    func goToDetail(imdbID: String)
}

class MainCoordinator: NSObject, MainCoordinatoring {
    weak var delegate: CommonCoordinatorToCoordinatorDelegate?
    var parentNavigationViewController: BaseNavigationController
    var coordinatorType: CoordinatorType = .main
    var navigationController: BaseNavigationController
    var childCoordinator: [Coordinator] = []
    
    private lazy var transition: SplashScreenTransition = {
        let transition = SplashScreenTransition()
        return transition
    }()
    
    required init(parentNavigationViewController: BaseNavigationController) {
        self.parentNavigationViewController = parentNavigationViewController
        self.navigationController = BaseNavigationController()
    }
    
    func start() {
        let vc = HomeBuilderImpl().build(coordinatorDelegate: self)
        vc.coordinatorDelegate = self
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.viewControllers = [vc]
            self?.navigationController.transitioningDelegate = self?.transition
            self?.navigationController.modalPresentationStyle = .fullScreen
            self?.parentNavigationViewController.present(self?.navigationController ?? BaseNavigationController(), animated: true, completion: nil)
        }
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
    
    func goToDetail(imdbID: String) {
        let vc = MovieDetailsBuilderImpl().build(coordinatorDelegate: self, imdbID: imdbID)
        vc.coordinatorDelegate = self
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension MainCoordinator: CommonControllerToCoordinatorDelegate {
    func commonControllerToCoordinator(type: AppFlowEventType) {
        switch type {
        case .main(let flowType):
            switch flowType {
            case .detail(let imdbID):
                goToDetail(imdbID: imdbID)
            }
            break
        default : break
        }
    }
}
