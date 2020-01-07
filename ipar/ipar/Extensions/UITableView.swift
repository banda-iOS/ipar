//
//  UITableView.swift
//  ipar
//
//  Created by Vitaly on 06/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func deselectAllRows() {
        for section in 0...self.numberOfSections - 1 {
           for row in 0...self.numberOfRows(inSection: section) - 1 {
            self.deselectRow(at: NSIndexPath(row: row, section: section) as IndexPath, animated: true)
           }
        }
    }
    
}
