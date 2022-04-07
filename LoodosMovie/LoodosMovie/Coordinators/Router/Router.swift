//
//  Router.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import Foundation

enum AppFlowEventType {
    case app, main
}

enum CoordinatorEventType {
    case finishCoordinator(coordinator: Coordinator)
}
