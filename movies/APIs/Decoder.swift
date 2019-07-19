//
//  Decoder.swift
//  movies
//
//  Created by Prekshya Admin on 19/7/19.
//  Copyright © 2019 Prekshya Admin. All rights reserved.
//

import Foundation

protocol Decoder {
    func decode<T: Decodable>(json: Data, Object:T.Type ,completion: @escaping (_ data: T?, _ error: Error?) -> Void)
}

struct JsonDecoder: Decoder {
    func decode<T: Decodable>(json: Data, Object:T.Type ,completion: @escaping (_ data: T?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let object = try decoder.decode(T.self, from: json)
            return completion(object, nil)
        } catch let error {
            return completion(nil, error)
        }
    }
}
