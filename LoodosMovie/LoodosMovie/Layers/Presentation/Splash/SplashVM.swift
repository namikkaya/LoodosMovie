//
//  SplashVM.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import Foundation

protocol SplashViewModel: ViewModel {
    
}

class SplashVM: SplashViewModel {
    var stateClosure: ((ObservationType<SplashObservation, ErrorEntity>) -> ())?
    typealias O = ObservationType
    private let configService: FirebaseRemoteConfigurable
    
    init(configService: FirebaseRemoteConfigurable) {
        self.configService = configService
    }
    
    func start() {
        fetchConfigData()
    }
    
}

extension SplashVM {
    enum SplashObservation {
        case configSuccess(title: String?)
    }
}

extension SplashVM {
    private func fetchConfigData() {
        self.configService.startService { [weak self] fetchStatus, title, error in
            if fetchStatus {
                self?.stateClosure?(.updateUI(data: .configSuccess(title: title)))
            }else{
                self?.stateClosure?(.error(error: error))
            }
        }
    }
}
