//
//  EventsSearchTableViewCell.swift
//  ipar
//
//  Created by Vitaly on 10/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

class EventsSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var distanceToEventLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
