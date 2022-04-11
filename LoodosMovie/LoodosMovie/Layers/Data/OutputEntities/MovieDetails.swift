//
//  MovieDetails.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation

struct MovieDetails: MovieBaseInfo {
    var Title: String?
    var Year: String?
    var imdbID: String?
    var Poster: String?
    var Ratings: [MovieRatingItem]?
    var Country: String?
    var Writer: String?
    var Actors: String?
    var Plot: String?
    var Director: String?
    var Released: String?
    var Awards: String?
}
