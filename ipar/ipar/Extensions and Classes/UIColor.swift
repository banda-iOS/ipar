//
//  UIColor.swift
//  ipar
//
//  Created by Vitaly on 04/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

extension UIColor
{
    class var backgroundRed: UIColor {
        return UIColor(red: 232.0/255, green: 67.0/255, blue: 66.0/255, alpha: 1.0)
    }
    class var defaultTextColor: UIColor {
        var color = UIColor()
        if #available(iOS 12.0, *) {
            if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
                color = .white
            } else {
                color = .black
            }
        } else {
            color = .black
        }
        return color
    }
    class var addPhotoColor: UIColor {
        return UIColor(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1.0)
    }
    class var midnightGreen: UIColor {
        return UIColor(red: 0.0/255, green: 53.0/255, blue: 34.0/255, alpha: 1.0)
    }
    class var highlightBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray5
        } else {
            return UIColor(red: 238.0/255, green: 239.0/255, blue: 244.0/255, alpha: 1.0)
        }
    }
    class var unselectedColor: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGray2
        } else {
            return UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1.0)
        }
    }
    class var graySpotifyColor: UIColor {
        return UIColor(red: 21/255.0, green: 21/255.0, blue: 24/255.0, alpha: 1.0)
    }
    class var unselectedTopTabColor: UIColor {
        return UIColor(red: 138/255.0, green: 138/255.0, blue: 144/255.0, alpha: 1.0)
    }
    class var groupedBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .systemGroupedBackground
        } else {
            return UIColor(red: 238.0/255, green: 239.0/255, blue: 244.0/255, alpha: 1.0)
        }
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
