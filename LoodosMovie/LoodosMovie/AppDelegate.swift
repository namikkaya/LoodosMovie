//
//  AppDelegate.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import UIKit
import Firebase
import FirebaseRemoteConfig
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var remoteConfig: RemoteConfig?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        startRemoteConfig()
        return true
    }
}

extension AppDelegate {
    private func startRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig?.configSettings = settings
        fetchConfig()
    }
    
    private func fetchConfig() {
        remoteConfig?.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig?.activate { changed, error in
              // data
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
          //self.displayWelcome()
            // hareket
        }
    }
}

