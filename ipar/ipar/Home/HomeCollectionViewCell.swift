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
    @IBOutlet weak var homeCellLabelView: UIView!
    @IBOutlet weak var homeCellDateView: UIView!
    @IBOutlet weak var homeCellDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 10
        homeCellLabel.font = UIFont.systemFont(ofSize: 17)
        homeCellLabel.textColor = .white
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.frame = homeCellLabelView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        homeCellLabelView.insertSubview(blurEffectView, belowSubview: homeCellLabel)
        
        homeCellDate.font = UIFont.systemFont(ofSize: 12)
        homeCellDate.textColor = .white
        homeCellDateView.backgroundColor = .backgroundRed
        homeCellImageView.contentMode = .scaleAspectFill
    }

    public func update(title: String, imageLink: String?, distance: String?) {
        if let imageLink = imageLink {
            homeCellImageView.kf.setImage(with: URL(string: staticUrlAddress + imageLink))
        }
        homeCellLabel.text = title
        if let distance = distance {
            homeCellDate.text = distance
        } else {
            homeCellDate.text = ""
        }
         // TODO: сделать удаленность
    }
}
