//
//  MovieServiceProtocol.swift
//  LoodosMovie
//
//  Created by namik kaya on 8.04.2022.
//

import Foundation
import Alamofire

class ApiManager {
    private let apiKey:String = "9960e2dc"
    private let pathBody:String = "http://www.omdbapi.com/"
}

extension ApiManager {
    func fetchData<Input: Encodable, Output:Decodable>(httpMethod: HTTPMethod = .get,
                                                       parameters: Input,
                                                       outPutEntity: Output.Type,
                                                       completion: @escaping (_ data: Output?, _ error: Error?) -> () = {_, _ in}) {
        AF.request("\(pathBody)?apikey=\(apiKey)", method: httpMethod, parameters: parameters).responseDecodable(of: outPutEntity, queue: .global(qos: .background)) { response in
            switch response.result {
            case let .success(result):
                completion(result, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
}
