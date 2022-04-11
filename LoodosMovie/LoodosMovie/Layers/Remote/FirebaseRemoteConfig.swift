//
//  FirebaseRemoteConfigService.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import Foundation
import FirebaseRemoteConfig

protocol FirebaseRemoteConfigurable {
    func startService(completion: @escaping FirebaseRemoteConfig.FirebaseRemoteConfigCompletionType)
}

class FirebaseRemoteConfig:NSObject, FirebaseRemoteConfigurable {
    typealias FirebaseRemoteConfigCompletionType = (_ fetchStatus: Bool, _ loodosTitle: String?, _ error: ErrorEntity?) -> ()
    private let service = RemoteConfig.remoteConfig()
    private let settings = RemoteConfigSettings()
    
    override init() {
        super.init()
    }
    
    func startService(completion: @escaping FirebaseRemoteConfigCompletionType) {
        startRemoteConfig(completion: completion)
    }
    
    private func startRemoteConfig(completion: @escaping FirebaseRemoteConfigCompletionType) {
        settings.minimumFetchInterval = 0
        service.configSettings = settings
        
        let appNameConfig: [String: Any?] = [
            "appName": "Loodos"
        ]
        service.setDefaults(appNameConfig as? [String: NSObject])
        
        service.fetchAndActivate { [weak self] (status, error) in
            guard error == nil else {
                completion(false, nil, ErrorEntity(title: "Config not fetched", message: error?.localizedDescription))
                return
            }
            let config = self?.service.configValue(forKey: "appName").stringValue
            completion(true, config, nil)
        }
        
    }
    
}
