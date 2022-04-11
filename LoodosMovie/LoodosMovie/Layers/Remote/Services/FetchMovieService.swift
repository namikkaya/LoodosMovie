//
//  fetchMovieService.swift
//  LoodosMovie
//
//  Created by namik kaya on 8.04.2022.
//

import Foundation

protocol FetchMovieServiceProtocol {
    func fetchMovie(keyword: String?, completion: @escaping FetchMovieService.FetchMovieCompletion)
}

struct FetchMovieService: FetchMovieServiceProtocol {
    private let apiManager: ApiManager
    
    typealias FetchMovieCompletion = (_ status: Bool, _ response: SearchResponseModel?, _ error: ErrorEntity?) -> ()
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func fetchMovie(keyword: String?, completion: @escaping FetchMovieCompletion) {
        apiManager.fetchData(httpMethod: .get, parameters: InputMovieSearchModel(s: keyword), outPutEntity: SearchResponseModel.self) { data, error in
            if let error = error {
                let errorEntity = ErrorEntity(title: "Bir hata oluştu", message: error.localizedDescription)
                completion(false, nil, errorEntity)
            } else {
                completion(true, data, nil)
            }
        }
    }
}
