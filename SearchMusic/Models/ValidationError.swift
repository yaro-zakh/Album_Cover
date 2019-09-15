//
//  ValidationError.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/14/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

public struct ValidationError: Error {
    
    var message: String?
    var name: String?

    init(name: String?, message: String?) {
        self.name = name
        self.message = message
    }
}
