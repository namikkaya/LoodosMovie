//
//  AppDelegate.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import UIKit
import Firebase
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinatoring?
    let network = NetworkManager()
    
    var noConnectionVC: NoInternetConnectionVC?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window!.overrideUserInterfaceStyle = .light
        let navController = BaseNavigationController()
        
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        setupNetworkListener()
        setupCoordinator(navController: navController)
        
        return true
    }
    
    private func setupCoordinator(navController: BaseNavigationController) {
        coordinator = AppCoordinator(navigationController: navController)
        coordinator?.start()
    }
    
    private func setupNetworkListener() {
        network.isReachable { [weak self] status in
            if (status) {
                if self?.noConnectionVC != nil {
                    self?.noConnectionVC?.dismiss(animated: false)
                    self?.noConnectionVC = nil
                }
            }else {
                if self?.noConnectionVC == nil {
                    self?.noConnectionVC = NoInternetConnectionVC(nibName: NoInternetConnectionVC.className, bundle: nil)
                    self?.noConnectionVC?.modalPresentationStyle = .overFullScreen
                    DispatchQueue.main.async {
                        self?.window?.rootViewController?.present(self?.noConnectionVC ?? UIViewController(), animated: false)
                    }
                }
            }
        }
    }
}

