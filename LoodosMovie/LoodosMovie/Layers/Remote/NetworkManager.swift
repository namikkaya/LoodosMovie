//
//  NetworkManager.swift
//  LoodosMovie
//
//  Created by namik kaya on 11.04.2022.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    var reachability: Reachability!
    
    override init() {
        super.init()
        reachability = try! Reachability()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // change network status
    }
    
    
    // Network is reachable
    func isReachable(completion: @escaping (Bool) -> Void) {
        completion(reachability.connection != .unavailable)
    }
}
