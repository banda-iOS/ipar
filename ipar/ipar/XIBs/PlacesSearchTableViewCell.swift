//
//  PlacesSearchTableViewCell.swift
//  ipar
//
//  Created by Vitaly on 02/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

class PlacesSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeTitleLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
