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

protocol ViewModel {
    /*associatedtype CLS
    var stateClosure: ((CLS) -> ())? { get set }*/
    func start()
}
