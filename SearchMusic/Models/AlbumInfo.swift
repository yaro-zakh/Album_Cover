//
//  AlbumInfo.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/8/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

struct AlbumInfo: Codable {
    let data: [Album]
}

struct Album: Codable {
    let id: Int
    let title: String
    let coverXl: URL
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case coverXl = "cover_xl"
    }
}
