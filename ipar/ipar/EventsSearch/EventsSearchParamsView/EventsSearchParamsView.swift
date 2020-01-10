//
//  EventsSearchParamsView.swift
//  ipar
//
//  Created by Vitaly on 10/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

protocol EventsSearchParamsDelegate: class {
    func updateFields(_ fields: EventsSearchFields)
    func presentTimeVC(_ vc: UIViewController)
}

class EventsSearchParamsView: UIView {
    
    weak var delegate: EventsSearchParamsDelegate?
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Maximum distance to place", comment: "Maximum distance to place label")
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    let distanceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 5000
        slider.value = 1000
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.heightAnchor.constraint(equalToConstant: 40)
        return slider
    }()
    
    let notMoreLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("not more than", comment: "not more then distance")
        label.textAlignment = .right
        return label
    }()
    
    let distanceField: UITextField = {
        let textField = UITextField()
        textField.text = "\(10000)"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("m", comment: "meters")
        return label
    }()
    
    let hashtagsTextField: UITextView = {
        let hashtagsField = UITextView()
        hashtagsField.isEditable = true
        hashtagsField.translatesAutoresizingMaskIntoConstraints = false
        hashtagsField
            .heightAnchor.constraint(equalToConstant: 100).isActive = true
        hashtagsField.font = UIFont.systemFont(ofSize: 15)
        hashtagsField.layer.cornerRadius = 5
        hashtagsField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        hashtagsField.layer.borderWidth = 0.5
        hashtagsField.clipsToBounds = true
        return hashtagsField
    }()
    
    let nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("Name of place (or part of it)", comment: "place name field placeholder")
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    let wordsInDescriptionField: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("Words in description", comment: "words in description field placeholder")
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    let timeTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.register(UINib(nibName: "TimeTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeTableViewCell")
        return tableView
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    var stackView = UIStackView()
    
    var from = Date()
    var to = Date()
    
    func createFields() {
        if UIScreen.main.nativeBounds.height < 1400 {
            self.addSubview(scrollView)
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -0.0).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.0).isActive = true
        }
        
        self.backgroundColor = .backgroundRed
         
        let distanceHorizontalStackView = UIStackView(arrangedSubviews: [notMoreLabel, distanceField, valueLabel])
        distanceHorizontalStackView.axis = .horizontal
        distanceHorizontalStackView.distribution = .fill
        distanceHorizontalStackView.alignment = .center
        distanceHorizontalStackView.spacing = 5
        distanceHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        distanceHorizontalStackView.heightAnchor.constraint(equalToConstant: 40)
        distanceHorizontalStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        distanceHorizontalStackView.isLayoutMarginsRelativeArrangement = true
        
        let distanceStackView = UIStackView(arrangedSubviews: [distanceLabel, distanceSlider, distanceHorizontalStackView])
        distanceStackView.axis = .vertical
        distanceStackView.distribution = .fillProportionally
        distanceStackView.alignment = .fill
        distanceStackView.spacing = 5
        distanceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        distanceStackView.addBackground(color: .highlightBackground)
        
        timeTableView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        stackView = UIStackView(arrangedSubviews: [distanceStackView, hashtagsTextField, nameField, wordsInDescriptionField, timeTableView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
       

        if UIScreen.main.nativeBounds.height < 1400 {
            scrollView.addSubview(stackView)
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -200).isActive = true
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        } else {
            self.addSubview(stackView)
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        }
        
       
        timeTableView.delegate = self
        timeTableView.dataSource = self
        
        
        
        distanceSlider.addTarget(self, action: #selector(sliderChangedValue), for: .touchUpInside)
        distanceField.addTarget(self, action: #selector(distanceFieldChangedValue), for: .editingDidEnd)
        
        //хэштег таргет
        nameField.addTarget(self, action: #selector(anyFieldChangedValue), for: .editingDidEnd)
        wordsInDescriptionField.addTarget(self, action: #selector(anyFieldChangedValue), for: .editingDidEnd)
    }
    
    func addTimeTable() {
        print("1234r")
        print(stackView.frame.height)
        
        timeTableView.delegate = self
        timeTableView.dataSource = self
    }
    
    
    
    @objc func sliderChangedValue() {
        var realValue: Float = 0
        switch distanceSlider.value {
        case 0..<1000:
            realValue = (distanceSlider.value)
        case 1000..<2000:
            realValue = 1000 + ((distanceSlider.value)-1000) * 9
        case 2000..<3000:
            realValue = 10000 + ((distanceSlider.value)-2000) * 90
        case 3000..<4000:
            realValue = 100000 + ((distanceSlider.value)-3000) * 900
        case 4000...distanceSlider.maximumValue:
            realValue = 1000000 + ((distanceSlider.value)-4000) * 9000
        default:
            realValue = 14_000_000
        }
        
        if realValue > 10000 {
            distanceField.text = String(format: "%.2f", realValue/1000)
            valueLabel.text = NSLocalizedString("km", comment: "kilometers")
        } else {
            distanceField.text = "\(Int(realValue))"
            valueLabel.text = NSLocalizedString("m", comment: "meters")
        }

        self.anyFieldChangedValue()
    }
    
    @objc func distanceFieldChangedValue(){
        var distanceFieldValue = Float(distanceField.text ?? "100")
        guard var distance = distanceFieldValue, distance > 0 else {
//            ВЫВОДИТЬ ALERT
            
            return
        }
        
        if valueLabel.text == NSLocalizedString("km", comment: "kilometers") {
            distance *= 1000
        }
        
        var sliderValue: Float = 0
        switch distance {
        case 0..<1000:
            sliderValue = distance
        case 1000..<10000:
            sliderValue = (distance-1000)/9 + 1000
        case 10_000..<100_000:
            sliderValue = (distance-10000)/90 + 2000
        case 100_000..<1_000_000:
            sliderValue = (distance-100000)/900 + 3000
        case 1_000_000..<10_000_000:
            sliderValue = (distance-1000000)/9000 + 4000
        default:
            sliderValue = distanceSlider.maximumValue
        }
        
        distanceSlider.value = sliderValue
        
        self.anyFieldChangedValue()
    }
    
    @objc func anyFieldChangedValue() {
        var fields = EventsSearchFields()
        if valueLabel.text == NSLocalizedString("km", comment: "kilometers") {
            fields.maxDistance = Int((Float(distanceField.text ?? "100") ?? 10)*1000)
        } else {
            fields.maxDistance = Int((Float(distanceField.text ?? "100") ?? 10000))
        }
        if hashtagsTextField.text != "" {
            fields.hashtags = hashtagsTextField.text
        }
        if nameField.text != "" {
            fields.name = nameField.text
        }
        if wordsInDescriptionField.text != "" {
            fields.description = wordsInDescriptionField.text
        }
        fields.from = self.from
        fields.to = self.to
        self.delegate?.updateFields(fields)
    }
}

extension EventsSearchParamsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableViewCell", for: indexPath) as! TimeTableViewCell
        if indexPath.row == 0 {
            cell.actionLabel.text = NSLocalizedString("Begins", comment: "time of event beginnning")
        } else {
            cell.actionLabel.text = NSLocalizedString("Ends", comment: "time of event ending")
        }
        cell.dateLabel.text = Date(timeIntervalSinceNow: 0).toDateString()
        cell.timeLabel.text = Date(timeIntervalSinceNow: 0).toTimeString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        timeTableView.deselectAllRows()
        let timeViewController = TimeViewController(withDatePickerType: .any)
        if indexPath.row == 0 {
            timeViewController.datePickerType = .from
        } else {
            timeViewController.datePickerType = .to
        }
        timeViewController.delegate = self
        self.delegate?.presentTimeVC(timeViewController)
        
        
        blurEffectView.frame = self.bounds
        self.addSubview(self.blurEffectView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}

extension EventsSearchParamsView: TimeViewDelegate {
    func addFromTime(_ time: Date) {
        self.from = time
        let cell = self.timeTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TimeTableViewCell
        cell.dateLabel.text = time.toDateString()
        cell.timeLabel.text = time.toTimeString()
        self.anyFieldChangedValue()
        self.blurEffectView.removeFromSuperview()
    }
    
    func addToTime(_ time: Date) {
        self.to = time
        let cell = self.timeTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TimeTableViewCell
        cell.dateLabel.text = time.toDateString()
        cell.timeLabel.text = time.toTimeString()
        self.anyFieldChangedValue()
        self.blurEffectView.removeFromSuperview()
    }
}
