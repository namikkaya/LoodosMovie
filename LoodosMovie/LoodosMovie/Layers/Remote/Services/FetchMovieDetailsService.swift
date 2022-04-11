//
//  FetchMovieDetailsService.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation

protocol FetchMovieDetailsServiceProtocol {
    func fetchMovieDetails(imdbID: String?, completion: @escaping FetchMovieDetailsService.FetchMovieDetailsCompletion)
}

struct FetchMovieDetailsService: FetchMovieDetailsServiceProtocol {
    private let apiManager: ApiManager
    
    typealias FetchMovieDetailsCompletion = (_ status: Bool, _ response: MovieDetails?, _ error: ErrorEntity?) -> ()
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func fetchMovieDetails(imdbID: String?, completion: @escaping FetchMovieDetailsCompletion) {
        apiManager.fetchData(httpMethod: .get, parameters: InputMovieDetailModel(i: imdbID), outPutEntity: MovieDetails.self) { data, error in
            if let error = error {
                let errorEntity = ErrorEntity(title: "Bir hata oluştu", message: error.localizedDescription)
                completion(false, nil, errorEntity)
            } else {
                completion(true, data, nil)
            }
        }
    }
}
