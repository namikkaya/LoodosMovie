//
//  SearchMovieUseCase.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation

protocol ListMovieUseCase {
    func fetchSearchList(keyword: String, completion: @escaping FetchMovieService.FetchMovieCompletion)
}

struct ListMovieUseCaseImpl: ListMovieUseCase {
    
    private let searchService: FetchMovieServiceProtocol
    init(searchServise: FetchMovieServiceProtocol) {
        self.searchService = searchServise
    }
    
    func fetchSearchList(keyword: String, completion: @escaping FetchMovieService.FetchMovieCompletion) {
        searchService.fetchMovie(keyword: keyword, completion: completion)
    }
}
