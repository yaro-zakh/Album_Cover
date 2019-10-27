//
//  MainViewPresenter.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/14/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

protocol MainView: class {
    func showAlertMessage(with error: ValidationError)
    func presentAlbumVC(with artwork: SearchHistory)
    func showActivityIndicator()
    func hideActivityIndicator()
}

final class MainViewPresenter {
    
    // MARK: - Properties
    private weak var view: MainView?
    private var apiService: ApiServiceConfigurable
    private var searchDataValidator: TextInputVerifiable
    
    var searchData: SearchData?
    
    var artworkInfo = [SearchHistory]()
    var artwork = Artworks()
    
    init(with view: MainView) {
        self.view = view
        self.searchDataValidator = TextInputValidator()
        
        let networkManager = NetworkManager()
        self.apiService = ApiService(apiManager: networkManager)
    }
    
    func checkInputsBeforeSearch(with searchText: String?) {
        view?.showActivityIndicator()
        let result = searchDataValidator.isValid(searchText: searchText)
        
        switch result {
        case let .success(searchData):
            self.searchData = searchData
            findArtist(with: searchData)
        case let .error(error):
            view?.hideActivityIndicator()
            view?.showAlertMessage(with: error)
        }
    }
    
    private func findArtist(with searchData: SearchData) {
        artwork = Artworks()
        
        apiService.fetchArtist(with: searchData) { [weak self] artistInfo, error in
            guard let self = self else { return }
            if let artistInfo = artistInfo {
                self.artwork.artist = artistInfo.data[0]
                if let artistID = self.artwork.artist?.id {
                    self.findAlbum(with: String(artistID))
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.showAlertMessage(with: ValidationError(name: "Error", message: "Artist not found"))
                    self.view?.hideActivityIndicator()
                }
            }
        }
    }
    
    private func findAlbum(with artistID: String) {
        apiService.fetchAlbum(with: artistID) { [weak self] albumInfo, error in
            guard let self = self else { return }
            if let albumInfo = albumInfo,
                let title = self.searchData?.albumName,
                let album = albumInfo.data.first(where: { album -> Bool in
                    album.title.localizedStandardContains(title) }) {
                self.artwork.album = album
                self.saveData()
                if let searchHistory = self.artworkInfo.last {
                    DispatchQueue.main.async {
                        self.view?.presentAlbumVC(with: searchHistory)
                        self.view?.hideActivityIndicator()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.showAlertMessage(with: ValidationError(name: "Error", message: "Album not found"))
                    self.view?.hideActivityIndicator()
                }
            }
        }
    }
    
    private func saveData() {
        let searchArt = SearchHistory(context: PersistenceService.context)
        searchArt.artist = artwork.artist?.name
        searchArt.track = artwork.album?.title
        
        if let imageURL = artwork.album?.coverXl, let data = try? Data(contentsOf: imageURL) {
            searchArt.image = data
        }
        
        PersistenceService.saveContext()
        self.artworkInfo.append(searchArt)
    }
}
