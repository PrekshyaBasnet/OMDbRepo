//
//  OMDBApis.swift
//  movies
//
//  Created by Prekshya Admin on 19/7/19.
//  Copyright © 2019 Prekshya Admin. All rights reserved.
//

import Foundation

protocol Endpoint {
    var url: String { get set }
    var apiKey: String { get set }
    var headers: [String: Any]? { get set }
    var queryString: String { get set }
    var httpMethod: String { get set }
}

struct OMDBApiEndpoint: Endpoint {
    var url: String
    var apiKey: String
    var headers: [String : Any]?
    var queryString: String
    var httpMethod: String
}


class OMDBApi {
    private var decoder: Decoder!
    init(decoder: Decoder) {
        self.decoder = decoder
    }
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    func getSearchResults(endpoint: Endpoint, completion: @escaping ([Movie], String?) -> Void) {
        if var urlComponents = URLComponents(string: endpoint.url) {
            urlComponents.query = "apikey=\(endpoint.apiKey)&s=\(endpoint.queryString)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer { self?.dataTask = nil }
                self?.getMovies(data: data, response: response as? HTTPURLResponse, error: error, completion: { (movies, errorMsgs) in
                    completion(movies, errorMsgs)
                })
            }
            dataTask?.resume()
        }
    }
    
    private func getMovies(data: Data?, response: HTTPURLResponse?, error: Error?, completion: @escaping ([Movie], String?) -> Void) {
        if error != nil {
            completion([], response?.statusCode.description ?? error?.localizedDescription)
        } else if let data = data, response!.statusCode == 200 {
            self.decoder.decode(json: data, Object: OMDBMovies.self, completion: { (movies, error) in
                DispatchQueue.main.async {
                    completion(movies?.movies ?? [], nil)
                }
            })
        } else {
            completion([], response?.statusCode.description ?? error?.localizedDescription)
        }
    }
}


