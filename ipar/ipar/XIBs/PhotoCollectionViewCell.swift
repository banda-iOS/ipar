//
//  PhotoCollectionViewCell.swift
//  ipar
//
//  Created by Vitaly on 15/11/2019.
//  Copyright © 2019 iamfrommoscow. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 10.0
    }

}
