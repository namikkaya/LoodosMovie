//
//  Router.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import Foundation

enum AppFlowEventType {
    case app(flowType: AppFlowType),
         main(flowType: MainFlowType)
}

enum CoordinatorEventType {
    case finishCoordinator(coordinator: Coordinator)
}

enum AppFlowType {
    case goToMain
}

enum MainFlowType {
    case detail(imdbID:String)
}
