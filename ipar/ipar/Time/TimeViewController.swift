//
//  TimeViewController.swift
//  ipar
//
//  Created by Vitaly on 25/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit

@objc protocol TimeViewDelegate {
    @objc optional func addFromTime(_ time: Date)
    @objc optional func addToTime(_ time: Date)
    @objc optional func addDefaultTime(_ time: Date)
}

enum DatePickerType {
    case from
    case to
    case any
}

class TimeViewController: UIViewController {
    
    var datePickerType: DatePickerType
    weak var delegate: TimeViewDelegate?
    
    init(withDatePickerType datePickerType: DatePickerType) {
        self.datePickerType = datePickerType
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        switch datePickerType {
        case .from:
            delegate?.addFromTime?(datePicker.date)
        case .to:
            delegate?.addToTime?(datePicker.date)
        default:
            delegate?.addDefaultTime?(datePicker.date)
        }
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
