//
//  NetworkManager.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/13/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

enum APIConnections: String {
    case artist
    case albums
}

enum APIObject: String {
    case search
    case artist
}

struct NetworkManager {
    
    private let scheme = "https"
    private let host = "api.deezer.com"

    private let urlSession = URLSession.shared
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        return urlComponents
    }
    
    func searchObject(object: APIObject, connection: APIConnections, search: String, limit: String, completion: @escaping(Data?, Error?) -> Void) {
        fetch(with: object, connection, parameters: [
            "q": search,
            "limit": limit
            ], completion: completion)
    }
    
    func searchCoverArt(object: APIObject, id artist: String, connection: APIConnections, completion: @escaping(Data?, Error?) -> Void) {
        fetch(with: object, id: artist, connection, completion: completion)
    }
    
    private func fetch(with object: APIObject, id: String? = nil, _ connection: APIConnections, parameters: [String: String]? = nil, completion: @escaping(Data?, Error?) -> Void) {
        var components = self.urlComponents
        let id = id ?? ""
        components.path = "/\(object)/\(id + "/")\(connection)"
        components.setQueryItems(with: parameters)
        guard let url = components.url else {
            completion(nil, NSError(domain: "", code: 100, userInfo: nil))
            return
        }
        urlSession.dataTask(with: url) { (data, _, error) in
            completion(data, error)
            }.resume()
    }
    
}
