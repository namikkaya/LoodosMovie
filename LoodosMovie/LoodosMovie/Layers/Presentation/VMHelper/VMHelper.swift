//
//  VMHelper.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation

enum ObservationType<T, E> {
    case updateUI(data: T? = nil), error(error: E?)
}

protocol ViewModelProtocol {
    associatedtype O
    var stateClosure: ((O) -> ())? { get set }
    func start()
}