//
//  URLComponenExtension.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/8/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]?) {
        if let parameters = parameters {
            self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
    }
}
