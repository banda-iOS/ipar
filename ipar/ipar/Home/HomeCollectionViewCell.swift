//
//  HomeCollectionViewCell.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

//import UIKit
//
//class HomeCollectionViewCell: UICollectionViewCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//}

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeCellImageView: UIImageView!
    @IBOutlet weak var homeCellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 4
        homeCellLabel.font = UIFont.systemFont(ofSize: 14)
    }

    public func update(title: String, imageLink: String) {
        homeCellImageView.kf.setImage(with: URL(string: "http://82.146.62.124:8081/" + imageLink))
        homeCellLabel.text = title
    }
}
