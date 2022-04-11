//
//  DetailMovieUseCase.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation

protocol DetailMovieUseCase {
    func fetchMovieDetails(imdbID: String?, completion: @escaping FetchMovieDetailsService.FetchMovieDetailsCompletion)
    func logEvent(detail: MovieDetails)
}

struct DetailMovieUseCaseImpl: DetailMovieUseCase {
    private let detailService: FetchMovieDetailsServiceProtocol
    private let analytics: AnalyticsLogable
    init(detailService: FetchMovieDetailsServiceProtocol, analytics: AnalyticsLogable) {
        self.detailService = detailService
        self.analytics = analytics
    }
    
    func fetchMovieDetails(imdbID: String?, completion: @escaping FetchMovieDetailsService.FetchMovieDetailsCompletion) {
        detailService.fetchMovieDetails(imdbID: imdbID, completion: completion)
    }
    
    func logEvent(detail: MovieDetails) {
        analytics.logEvent(detail: detail)
    }
}
