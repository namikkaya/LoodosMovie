//
//  MovieDetailsBuilder.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation

protocol MovieDetailsBuilder {
    func build(coordinatorDelegate: CommonControllerToCoordinatorDelegate, imdbID: String) -> BaseViewController
}

struct MovieDetailsBuilderImpl: MovieDetailsBuilder {
    func build(coordinatorDelegate: CommonControllerToCoordinatorDelegate, imdbID: String) -> BaseViewController {
        let vc = MovieDetailsVC.init(nibName: MovieDetailsVC.className, bundle: nil)
        let apiManager = ApiManager()
        let analytics = AnalyticsManager()
        let service = FetchMovieDetailsService(apiManager: apiManager)
        let useCase = DetailMovieUseCaseImpl(detailService: service, analytics: analytics)
        let vm = MovieDetailsVM(useCase: useCase, imdbID: imdbID)
        vc.injectVM(vm: vm)
        return vc
    }
}
