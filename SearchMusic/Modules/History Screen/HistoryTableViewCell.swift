//
//  HistoryTableViewCell.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/12/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    var artwork: SearchHistory? {
        didSet {
            trackNameLabel.text = artwork?.track
            artistNameLabel.text = artwork?.artist
            if let data = artwork?.image {
                albumImageView.image = UIImage(data: data)
            } else {
                albumImageView.image = UIImage(named: "noImage")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
