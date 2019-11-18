//
//  HomeCollectionViewCell.swift
//  ipar
//
//  Created by Elizaveta Dobrianskaia on 11/13/19.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var HomeCellImageView: UIImageView!
    @IBOutlet weak var HomeCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 4
        HomeCellLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
    func update(title: String, imageLink: String) {
        HomeCellImageView.kf.setImage(with: URL(string: imageLink))
        HomeCellLabel.text = title
    }
}
