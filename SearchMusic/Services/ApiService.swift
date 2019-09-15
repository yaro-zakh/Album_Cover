//
//  ApiService.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/14/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

protocol ApiServiceConfigurable {
    func fetchArtist(with searchData: SearchData, completion: @escaping (_ artistInfo: ArtistInfo?, _ error: Error?) -> Void)
    func fetchAlbum(with artistID: String, completion: @escaping (_ albumInfo: AlbumInfo?, _ error: Error?) -> Void)
}

final class ApiService: ApiServiceConfigurable {
    
    private var apiManager: NetworkManager
    
    init(apiManager: NetworkManager) {
        self.apiManager = apiManager
    }
    
    func fetchArtist(with searchData: SearchData, completion: @escaping (_ artistInfo: ArtistInfo?, _ error: Error?) -> Void) {
        apiManager.searchObject(object: .search, connection: .artist, search: searchData.artistName, limit: "1") { data, error in
            if let data = data {
                guard let artistInfo = try? JSONDecoder().decode(ArtistInfo.self, from: data) else {
                    print("Error: can't parse ArtistInfo")
                    completion(nil, error)
                    return
                }
                completion(artistInfo, nil)
            } else if (error != nil) {
                print(error?.localizedDescription ?? "no Description")
                completion(nil, error)
                return
            }
        }
    }
    
    func fetchAlbum(with artistID: String, completion: @escaping (_ albumInfo: AlbumInfo?, _ error: Error?) -> Void) {
        apiManager.searchCoverArt(object: .artist, id: artistID, connection: .albums, completion: { data, error in
            if let data = data {
                guard let albumInfo = try? JSONDecoder().decode(AlbumInfo.self, from: data) else {
                    print("Error: can't parse AlbumInfo")
                    completion(nil, error)
                    return
                }
                completion(albumInfo, nil)
            } else if error != nil {
                print(error?.localizedDescription ?? "no Description")
                completion(nil, error)
                return
            }
        })
    }
}
