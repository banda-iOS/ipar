
import UIKit
import XLPagerTabStrip
import MapKit

class PlaceCreationViewController: UIViewController, PlaceCreationViewProtocol, IndicatorInfoProvider  {
    
    

    var itemInfo = IndicatorInfo(title: "View")
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleTextField: UITextField = {
        let sampleTextField =  UITextField()
        sampleTextField.placeholder = NSLocalizedString("Place title", comment: "place title field placeholder")
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.translatesAutoresizingMaskIntoConstraints = false

        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return sampleTextField
    }()
    
    let descriptionTextField: UITextView = {
        let descriptionField = UITextView()
        descriptionField.isEditable = true
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        descriptionField.font = UIFont.systemFont(ofSize: 15)
        descriptionField.layer.cornerRadius = 5
        descriptionField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        descriptionField.layer.borderWidth = 0.5
        descriptionField.clipsToBounds = true
        return descriptionField
    }()
    
    let hashstagsTextField: UITextView = {
        let hashtagsField = UITextView()
        hashtagsField.isEditable = true
        hashtagsField.translatesAutoresizingMaskIntoConstraints = false
        hashtagsField.font = UIFont.systemFont(ofSize: 15)
        hashtagsField.layer.cornerRadius = 5
        hashtagsField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        hashtagsField.layer.borderWidth = 0.5
        hashtagsField.clipsToBounds = true
        return hashtagsField
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let addPositionButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Add geo position", comment: "Add geo position button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 232.0/255, green: 67.0/255, blue: 66.0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(addPositionButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let margin: CGFloat = 30
    var addPositionButtonTopAnchorConstraint: NSLayoutConstraint?
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presenter: PlaceCreationPresenterProtocol!
    let configurator: PlaceCreationConfiguratorProtocol = PlaceCreationConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        descriptionTextField.delegate = self
        descriptionTextField.text = NSLocalizedString("Description", comment: "description field placeholder")
        descriptionTextField.textColor = .lightGray
        hashstagsTextField.delegate = self
        hashstagsTextField.text = NSLocalizedString("Hashtags", comment: "hashtags field placeholder")
        hashstagsTextField.textColor = .lightGray
        
        self.view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0.0).isActive = true

        scrollView.addSubview(titleTextField)

        titleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50.0).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        scrollView.addSubview(descriptionTextField)

        descriptionTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        descriptionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20.0).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 650.0).isActive = true
        
        scrollView.addSubview(hashstagsTextField)

        hashstagsTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        hashstagsTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        hashstagsTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20.0).isActive = true
        hashstagsTextField.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        scrollView.addSubview(addPositionButton)

        addPositionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        addPositionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        addPositionButtonTopAnchorConstraint = addPositionButton.topAnchor.constraint(equalTo: hashstagsTextField.bottomAnchor, constant: 20.0)
        addPositionButtonTopAnchorConstraint?.isActive = true
        addPositionButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        addPositionButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80.0).isActive = true
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    @objc func addPositionButtonPressed() {
        presenter.addPositionButtonPressed()
    }
    
    func userSelectedPlacemark(_ placemark: MKPlacemark, address: String) {
        
    }
     

}

extension PlaceCreationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView === descriptionTextField {
            if (descriptionTextField.text == NSLocalizedString("Description", comment: "description field placeholder") && textView.textColor == .lightGray) {
                descriptionTextField.text = ""
                descriptionTextField.textColor = .black
            }
            descriptionTextField.becomeFirstResponder()
        } else {
            if (hashstagsTextField.text == NSLocalizedString("Hashtags", comment: "hashtags field placeholder") && textView.textColor == .lightGray) {
                hashstagsTextField.text = ""
                hashstagsTextField.textColor = .black
            }
            hashstagsTextField.becomeFirstResponder()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView === descriptionTextField {
            if (descriptionTextField.text == ""){
                descriptionTextField.text = NSLocalizedString("Description", comment: "description field placeholder")
                descriptionTextField.textColor = .lightGray
            }
            descriptionTextField.resignFirstResponder()
        } else {
            if (hashstagsTextField.text == ""){
                hashstagsTextField.text = NSLocalizedString("Hashtags", comment: "hashtags field placeholder")
                hashstagsTextField.textColor = .lightGray
            }
            hashstagsTextField.resignFirstResponder()
        }
    }
   
}


