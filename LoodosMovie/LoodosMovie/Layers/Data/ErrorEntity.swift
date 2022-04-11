//
//  ErrorEntity.swift
//  LoodosMovie
//
//  Created by namik kaya on 7.04.2022.
//

import Foundation

struct ErrorEntity {
    enum ErrorType {
        case warning, error
    }
    var title: String?
    var message: String?
    var errorType: ErrorType = .error
}
