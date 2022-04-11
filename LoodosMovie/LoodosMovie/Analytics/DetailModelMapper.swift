//
//  DetailModelMapper.swift
//  LoodosMovie
//
//  Created by namik kaya on 10.04.2022.
//

import Foundation

protocol DetailModelMapable {
    associatedtype In
    associatedtype Out
    func mapper(_in: In) -> Out?
}

struct DetailModelMapper: DetailModelMapable {
    func mapper(_in: MovieDetails) -> MovieDetailAnalyticsModel? {
        do {
            let dictionary = try DictionaryEncoder().encode(_in)
            let outPut = try DictionaryDecoder().decode(MovieDetailAnalyticsModel.self, from: dictionary)
            return outPut
        } catch {
            return nil
        }
    }
    
    typealias In = MovieDetails
    
    typealias Out = MovieDetailAnalyticsModel
    
}
