//
//  AlbumViewPresenter.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/14/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

protocol AlbumView: class {
    func displayAlbumInfo(with album: String?, artist: String?, cover: Data)
}

final class AlbumViewPresenter {
    
    // MARK: - Properties
    private weak var view: AlbumView?
    private var artwork: SearchHistory

    init(with view: AlbumView, artwork: SearchHistory) {
        self.view = view
        self.artwork = artwork
    }
    
    func viewDidLoad() {
        setupAlbumInfo()
    }
    
    private func setupAlbumInfo() {
        if let imageData = artwork.image {
            view?.displayAlbumInfo(with: artwork.track, artist: artwork.artist, cover: imageData)
        }
    }
}
