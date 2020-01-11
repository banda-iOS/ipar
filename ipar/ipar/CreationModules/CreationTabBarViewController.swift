//
//  CreationTabBarViewController.swift
//  ipar
//
//  Created by Vitaly on 10/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class CreationTabBarViewController: ButtonBarPagerTabStripViewController, ObjectCreationDelegate {
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .graySpotifyColor
//        settings.style.buttonBarBackgroundColor = .green
        settings.style.buttonBarItemBackgroundColor = .graySpotifyColor
//        settings.style.buttonBarItemBackgroundColor = .blue
        settings.style.selectedBarBackgroundColor = .backgroundRed
//        settings.style.selectedBarBackgroundColor = .red
        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:14) ?? UIFont.systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
//        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemTitleColor = .yellow
        settings.style.buttonBarItemsShouldFillAvailableWidth = true

        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
        

        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .unselectedTopTabColor
//            oldCell?.label.textColor = .brown
            newCell?.label.textColor = .white
//            newCell?.label.textColor = .purple
        }

        super.viewDidLoad()
        
        var navItemHeight: CGFloat = 0
        if let navHeight = self.navigationController?.navigationBar.frame.size.height {
            navItemHeight = navHeight
        }
        
        self.buttonBarView.frame = CGRect(x: 0, y: navItemHeight + UIApplication.shared.statusBarFrame.height, width:  self.buttonBarView.frame.size.width, height: 44.0)
        
    }


    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let placeCreationViewController = PlaceCreationViewController(itemInfo: IndicatorInfo(title: NSLocalizedString("PLACE", comment: "Create place tab")))
        placeCreationViewController.delegate = self
        let eventCreationViewController = EventCreationViewController(itemInfo: IndicatorInfo(title: NSLocalizedString("EVENT", comment: "Create event tab")))
        eventCreationViewController.delegate = self
        
        return [eventCreationViewController, placeCreationViewController]
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismissVC()
    }
    
    @objc func dismissVC() {
        self.navigationController?.dismiss(animated: true, completion:nil)
    }
    
    func objectCreated() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    }
    
    
}
