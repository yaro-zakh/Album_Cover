//
//  HistoryViewController.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/12/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var presenter: HistoryViewPresenter!
    
    @IBOutlet weak var tableView: UITableView!
       
    private let cellIdentifier = "HistoryTableViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension HistoryViewController: HistoryView {
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func presentAlbumVC(_ artwork: SearchHistory) {
        let albumViewController = AlbumViewController()
        let albumPresenter = AlbumViewPresenter(with: albumViewController, artwork: artwork)
        albumViewController.presenter = albumPresenter
        present(albumViewController, animated: true, completion: nil)
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HistoryTableViewCell {
            cell.artwork = presenter.dataSource[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.row)
    }
}
