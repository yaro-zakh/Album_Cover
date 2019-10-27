//
//  UIImageViewExtension.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/6/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(url: URL?) {
        if let url = url {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.image = UIImage(named: "noImage")
            }
        }
    }
}
