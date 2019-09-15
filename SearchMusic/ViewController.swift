//
//  ViewController.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/6/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak private var searchText: UITextField!
    
    private let segueIdentifier = "historyViewController"
    private let networkManager = NetworkManager()
    var artworkInfo = [SearchHistory]()
    var searchFieldData: [String: String] = [:]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
    }
    
    fileprivate func setupBackButton() {
        let backButtonImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    private func errorAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HistoryViewController, segue.identifier == segueIdentifier {
            controller.searchHistory = artworkInfo
        }
    }
    
    private func presentAlbumVC(_ artwork: Artworks) {
        let albumImageViewController = AlbumImageViewController()
        albumImageViewController.artwork = artwork
        present(albumImageViewController, animated: true, completion: nil)
    }
    
    fileprivate func saveData(_ artwork: Artworks) {
        let searchArt = SearchHistory(context: PersistenceService.context)
        searchArt.artist = artwork.artistName
        searchArt.track = artwork.album?.title
        let imageFromURL = UIImageView()
        imageFromURL.load(url: artwork.album?.coverBig ?? nil)
        searchArt.image = imageFromURL.image?.pngData()
        PersistenceService.saveContext()
        self.artworkInfo.append(searchArt)
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        var artwork = Artworks()
        if let returnValue = artwork.setSoundInfo(searchText: searchText.text!) {
            errorAlertMessage(title: returnValue.title, message: returnValue.message)
            return
        }
        networkManager.getCoverArt(artwork: artwork) { (result) in
            if !result.data.isEmpty {
                artwork.album = result.data[0].album
                self.saveData(artwork)
                
                DispatchQueue.main.async {
                    self.presentAlbumVC(artwork)
                }
            } else {
                print("Something wrong 🤬")
            }
        }
    }
}
