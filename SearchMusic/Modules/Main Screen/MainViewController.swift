//
//  MainViewController.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/6/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenter!
    
    @IBOutlet weak private var searchText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    private let segueIdentifier = "historyViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainViewPresenter(with: self)
        
        setupButtonsStyle()
    }
    
    private func setupBackButton() {
        let backButtonImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    private func setupButtonsStyle() {
        setupBackButton()
        
        setupStyle(for: searchButton, with: .red)
        setupStyle(for: historyButton, with: .lightGray)
    }
    
    private func setupStyle(for button: UIButton, with color: UIColor) {
        button.backgroundColor = color.withAlphaComponent(0.3)
        button.layer.cornerRadius = 5
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        presenter.checkInputsBeforeSearch(with: searchText.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HistoryViewController, segue.identifier == segueIdentifier {
            let historyPresenter = HistoryViewPresenter(with: controller, artwork: presenter.artworkInfo)
            controller.presenter = historyPresenter
        }
    }
}

extension MainViewController: MainView {
    
    func showAlertMessage(with error: ValidationError) {
        let alert = UIAlertController(title: error.name, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func presentAlbumVC(with artwork: SearchHistory) {
        let albumViewController = AlbumViewController()
        let albumPresenter = AlbumViewPresenter(with: albumViewController, artwork: artwork)
        albumViewController.presenter = albumPresenter
        
        present(albumViewController, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
