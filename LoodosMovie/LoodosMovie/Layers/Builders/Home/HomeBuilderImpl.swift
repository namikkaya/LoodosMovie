//
//  HomeBuilder.swift
//  LoodosMovie
//
//  Created by namik kaya on 8.04.2022.
//

import Foundation

protocol HomeBuilder {
    func build(coordinatorDelegate: CommonControllerToCoordinatorDelegate) -> BaseViewController
}

struct HomeBuilderImpl: HomeBuilder {
    func build(coordinatorDelegate: CommonControllerToCoordinatorDelegate) -> BaseViewController {
        let vc = HomeVC.init(nibName: HomeVC.className, bundle: nil)
        let apiManager = ApiManager()
        let service = FetchMovieService(apiManager: apiManager)
        let useCase = ListMovieUseCaseImpl(searchServise: service)
        let vm = HomeVM(listUseCase: useCase)
        vc.injectVM(vm: vm)
        return vc
    }
}
