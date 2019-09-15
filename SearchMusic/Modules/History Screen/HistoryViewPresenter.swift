//
//  HistoryViewPresenter.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/14/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation
import CoreData

protocol HistoryView: class {
    func reloadView()
    func presentAlbumVC(_ artwork: SearchHistory)
}

final class HistoryViewPresenter {
    
    // MARK: - Properties
    private weak var view: HistoryView?

    var dataSource = [SearchHistory]()
    var numberOfItems: Int {
        return dataSource.count
    }

    init(with view: HistoryView, artwork: [SearchHistory]) {
        self.view = view
        self.dataSource = artwork
    }
    
    func viewDidLoad() {
        getDataFromDB()
    }
    
    func viewWillAppear() {
        view?.reloadView()
    }
    
    func didSelectItem(at index: Int) {
        if index < numberOfItems {
            view?.presentAlbumVC(dataSource[index])
        }
    }

    private func getDataFromDB() {
        let fetchRequest: NSFetchRequest<SearchHistory> = SearchHistory.fetchRequest()
        do {
            let searchHistory = try PersistenceService.context.fetch(fetchRequest)
            self.dataSource = searchHistory
            self.view?.reloadView()
        } catch {
            print("Can't load data")
        }
    }
}
