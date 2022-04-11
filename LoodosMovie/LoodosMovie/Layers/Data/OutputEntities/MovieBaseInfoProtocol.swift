//
//  MovieBaseInfo.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation

protocol MovieBaseInfoProtocol: Codable {
    var Title:String? { get set }
    var Year:String? { get set }
    var imdbID:String? { get set }
    var Poster:String? { get set }
}
