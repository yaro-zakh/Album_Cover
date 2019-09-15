//
//  AlbumViewController.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/12/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    var presenter: AlbumViewPresenter!

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        setupAlbumImage()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupAlbumImage() {
        albumImage.layer.cornerRadius = 20
        albumImage.clipsToBounds = true
    }
}

extension AlbumViewController: AlbumView {
    
    func displayAlbumInfo(with album: String?, artist: String?, cover: Data) {
        albumName.text = album
        artistName.text = artist
        albumImage.image = UIImage(data: cover)
    }
}
