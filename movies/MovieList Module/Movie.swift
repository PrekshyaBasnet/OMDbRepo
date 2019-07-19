//
//  Movie.swift
//  movies
//
//  Created by Prekshya Admin on 19/7/19.
//  Copyright © 2019 Prekshya Admin. All rights reserved.
//

import Foundation

struct OMDBMovies: Codable {
    var movies: [Movie]
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

struct Movie: Codable {
    var title: String
    var imdbID: String
    var year: String
    var type: String
    var poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case imdbID 
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}

