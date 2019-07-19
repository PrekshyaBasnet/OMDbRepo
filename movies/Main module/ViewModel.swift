//
//  ViewModel.swift
//  movies
//
//  Created by Prekshya Admin on 19/7/19.
//  Copyright © 2019 Prekshya Admin. All rights reserved.
//

import Foundation

struct ViewModel {
    var url: String!
    var apiKey: String!
    var headers: [String: Any]?
    var searchKey: String!
    var httpMethod: String = "GET"
    var omdbApi: OMDBApi!
    
    init(omdbApi: OMDBApi) {
        self.omdbApi = omdbApi
    }
    
    func requestMovies(completion: @escaping ([Movie],String?) -> Void) {
        let endpoint = OMDBApiEndpoint(url: url, apiKey: apiKey, headers: headers, queryString: searchKey, httpMethod: httpMethod)
        omdbApi.getSearchResults(endpoint: endpoint) { (movies, errorMessage) in
            DispatchQueue.main.async {
                completion(movies, errorMessage)
            }
        }
    }
    
    func getMovieVM(movies: [Movie], errorMsg: String? = nil) -> MoviesViewModel {
        return MoviesViewModel(movies: movies, errorMessage: errorMsg)
    }
}
