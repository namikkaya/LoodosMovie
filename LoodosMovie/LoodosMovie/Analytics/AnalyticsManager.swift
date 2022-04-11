//
//  AnalyticsManager.swift
//  LoodosMovie
//
//  Created by namik kaya on 10.04.2022.
//

import Foundation
import FirebaseAnalytics

protocol AnalyticsLogable {
    func logEvent(detail: MovieDetails)
}

struct AnalyticsManager: AnalyticsLogable {
    func logEvent(detail: MovieDetails) {
        if let dict = getDetailSerializationModel(detail) {
            Analytics.logEvent("MovieDetail", parameters: dict)
        }
    }
    
    private func getDetailSerializationModel(_ detail: MovieDetails) -> [String: Any]? {
        let analyticsModel = DetailModelMapper().mapper(_in: detail)
        return try! DictionaryEncoder().encode(analyticsModel) as? [String : Any]
    }
}
