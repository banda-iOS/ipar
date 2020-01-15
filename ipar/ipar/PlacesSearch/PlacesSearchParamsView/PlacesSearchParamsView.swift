//
//  PlacesSearchParamsView.swift
//  ipar
//
//  Created by Vitaly on 03/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

protocol PlacesSearchParamsDelegate: class {
    func updateFields(_ fields: PlacesSearchFields)
}

class PlacesSearchParamsView: UIView {
    
    weak var delegate: PlacesSearchParamsDelegate?
    
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
    
    let addressField: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("Address of the place (or part of it)", comment: "place address field placeholder")
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .midnightGreen
        button.clipsToBounds = true
        return button
    }()
    
    func createFields() {
        
        if UIScreen.main.nativeBounds.height < 4000 {
            self.addSubview(scrollView)
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -0.0).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100.0).isActive = true
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

        let stackView = UIStackView(arrangedSubviews: [distanceStackView, hashtagsTextField, nameField, wordsInDescriptionField, addressField, button])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        if UIScreen.main.nativeBounds.height < 4000 {
            scrollView.addSubview(stackView)
            scrollView.showsVerticalScrollIndicator = false
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -250).isActive = true
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        } else {
            self.addSubview(stackView)
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        }
        
        stackView.heightAnchor.constraint(equalToConstant: 250)
        
        distanceSlider.addTarget(self, action: #selector(sliderChangedValue), for: .touchUpInside)
        distanceField.addTarget(self, action: #selector(distanceFieldChangedValue), for: .editingDidEnd)
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.isHidden = true
        
        //хэштег таргет
        nameField.addTarget(self, action: #selector(anyFieldChangedValue), for: .editingDidEnd)
        wordsInDescriptionField.addTarget(self, action: #selector(anyFieldChangedValue), for: .editingDidEnd)
        addressField.addTarget(self, action: #selector(anyFieldChangedValue), for: .editingDidEnd)

        
    }
    
    func setPlacesCount(_ count: Int) {
        button.isHidden = false
        button.setTitle(NSLocalizedString("Number of places", comment: "Places number button")+": \(count)", for: .normal)
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
        var fields = PlacesSearchFields()
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
        if addressField.text != "" {
            fields.address = addressField.text
        }
        self.delegate?.updateFields(fields)
    }
}
