//
//  ArtistInfo.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/13/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

struct ArtistInfo: Codable {
    let data: [Atrist]
}

struct Atrist: Codable {
    let id: Int
    let name: String
}
