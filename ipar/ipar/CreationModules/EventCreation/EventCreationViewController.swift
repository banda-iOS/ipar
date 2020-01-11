
import UIKit
import XLPagerTabStrip

class EventCreationViewController: UIViewController, IndicatorInfoProvider  {
    
    weak var delegate: ObjectCreationDelegate?

    var presenter: EventCreationPresenterProtocol!
    let configurator: EventCreationConfiguratorProtocol = EventCreationConfigurator()
    
    var itemInfo = IndicatorInfo(title: "View")
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let titleTextField: UITextField = {
        let sampleTextField =  UITextField()
        sampleTextField.placeholder = NSLocalizedString("Event title", comment: "event title field placeholder")
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
    
    let hashtagsTextField: UITextView = {
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
    
    let addPlaceButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Add place to event", comment: "Place adding to event button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .backgroundRed
        button.addTarget(self, action: #selector(addPlaceButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UINib(nibName: "AddPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "addPhotoCell")
        cv.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        cv.backgroundColor = .none
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return cv
    }()
    
    let saveEventButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Save event", comment: "Save event button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .midnightGreen
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let imagePicker = UIImagePickerController()
    var images = [UIImage]()
    
    var placesView = PlacesView()
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    let margin: CGFloat = 10
    
    var scrollBottomAnchorConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        descriptionTextField.delegate = self
        descriptionTextField.text = NSLocalizedString("Description", comment: "description field placeholder")
        descriptionTextField.textColor = .lightGray
        hashtagsTextField.delegate = self
        hashtagsTextField.text = NSLocalizedString("Hashtags", comment: "hashtags field placeholder")
        hashtagsTextField.textColor = .lightGray
        
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
        descriptionTextField.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        scrollView.addSubview(hashtagsTextField)

        hashtagsTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        hashtagsTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        hashtagsTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20.0).isActive = true
        hashtagsTextField.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        scrollView.addSubview(addPlaceButton)
        
        addPlaceButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        addPlaceButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        addPlaceButton.topAnchor.constraint(equalTo: hashtagsTextField.bottomAnchor, constant: 125.0).isActive = true
        addPlaceButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        scrollBottomAnchorConstraint = addPlaceButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20.0)
        scrollBottomAnchorConstraint?.isActive = true
        
    }
    
    @objc func addPlaceButtonPressed() {
        presenter.addPlaceButtonPressed()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        scrollView.addSubview(timeTableView)
        timeTableView.dataSource = self
        timeTableView.delegate = self
        timeTableView.frame = CGRect(x: 0, y: hashtagsTextField.frame.maxY + 20, width: self.view.frame.width, height: 85.0)
        
       
        
        placesView = PlacesView(frame: CGRect(x: 0, y: addPlaceButton.frame.maxY + 20, width: self.view.frame.width, height: 505.0))
    }
    
    private func presentImagePicker() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func saveEventButtonPressed() {
        presenter.saveEventButtonPressed()
    }
    
    func eventSaved() {
        
        saveEventButton.removeFromSuperview()
        
        scrollView.addSubview(collectionView)
        
        imagePicker.delegate = self
        collectionView.dataSource = self
       
        collectionView.topAnchor.constraint(equalTo: placesView.bottomAnchor, constant: 10.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
       
        collectionView.showsHorizontalScrollIndicator = false
       
        collectionView.delegate = self
       
        scrollBottomAnchorConstraint?.isActive = false
        scrollBottomAnchorConstraint = collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -70)
        scrollBottomAnchorConstraint?.isActive = true
        
        self.delegate?.objectCreated()
    }
    


}


extension EventCreationViewController: UITableViewDelegate, UITableViewDataSource {
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
        present(timeViewController, animated: true, completion: nil)
        
        blurEffectView.frame = view.bounds
        view.addSubview(self.blurEffectView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension EventCreationViewController: TimeViewDelegate {
    func addFromTime(_ time: Date) {
        presenter.fromTimeAdded(date: time)
        self.blurEffectView.removeFromSuperview()
    }
    
    func addToTime(_ time: Date) {
        presenter.toTimeAdded(date: time)
        self.blurEffectView.removeFromSuperview()
    }
}

extension EventCreationViewController: EventCreationViewProtocol {
    func getTitle() -> String {
        return titleTextField.text ?? ""
    }
    
    func getDescription() -> String {
        return descriptionTextField.text
    }
    
    func getHashtags() -> String {
        return hashtagsTextField.text
    }
    
    func getPlaces() -> [Place] {
        placesView.getPlaces()
    }
    
    
    func changeDate(_ dateString: String, withTime timeString: String, type: DatePickerType) {
        var indexPath: IndexPath?
        if type == .from {
            indexPath = IndexPath(row: 0, section: 0)
        } else {
            indexPath = IndexPath(row: 1, section: 0)
        }
        if let indexPath = indexPath {
            let cell = timeTableView.cellForRow(at: indexPath) as! TimeTableViewCell
            cell.dateLabel.text = dateString
            cell.timeLabel.text = timeString
        }
    }
}

extension EventCreationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView){
        if textView === descriptionTextField {
            if (descriptionTextField.text == NSLocalizedString("Description", comment: "description field placeholder") && textView.textColor == .lightGray) {
                descriptionTextField.text = ""
                descriptionTextField.textColor = .defaultTextColor
                
            }
            descriptionTextField.becomeFirstResponder()
        } else {
            if (hashtagsTextField.text == NSLocalizedString("Hashtags", comment: "hashtags field placeholder") && textView.textColor == .lightGray) {
                hashtagsTextField.text = ""
                hashtagsTextField.textColor = .defaultTextColor
            }
            hashtagsTextField.becomeFirstResponder()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView){
        if textView === descriptionTextField {
            if (descriptionTextField.text == ""){
                descriptionTextField.text = NSLocalizedString("Description", comment: "description field placeholder")
                descriptionTextField.textColor = .lightGray
            }
            descriptionTextField.resignFirstResponder()
        } else {
            if (hashtagsTextField.text == ""){
                hashtagsTextField.text = NSLocalizedString("Hashtags", comment: "hashtags field placeholder")
                hashtagsTextField.textColor = .lightGray
            }
            hashtagsTextField.resignFirstResponder()
        }
    }
}

extension EventCreationViewController {
    @objc func Keyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}

extension EventCreationViewController: AddPlaceDelegate {
    func placeAdded(_ place: Place) {
        
        placesView.appendPlace(place)
        placesView.createFields()
        if !placesView.isDescendant(of: self.view) {
            scrollView.addSubview(placesView)
        }
        
        if !saveEventButton.isDescendant(of: self.view) {
            scrollView.addSubview(saveEventButton)
            saveEventButton.topAnchor.constraint(equalTo: placesView.bottomAnchor, constant: 10).isActive = true
            saveEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            saveEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            saveEventButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
            
            saveEventButton.addTarget(self, action: #selector(saveEventButtonPressed), for: .touchUpInside)
        }
        
        scrollBottomAnchorConstraint?.isActive = false
        scrollBottomAnchorConstraint = saveEventButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -70)
        scrollBottomAnchorConstraint?.isActive = true
        
       
        
        
//        placesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
//        placesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
//        placesView.topAnchor.constraint(equalTo: addPlaceButton.bottomAnchor, constant: 10.0).isActive = true
//        placesView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
//
//        addPlaceButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
//        addPlaceButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
//        addPlaceButton.topAnchor.constraint(equalTo: hashtagsTextField.bottomAnchor, constant: 125.0).isActive = true
//        addPlaceButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
}


extension EventCreationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhotoCell", for: indexPath) as! AddPhotoCollectionViewCell
            cell.contentView.clipsToBounds = true
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.borderColor = UIColor.addPhotoColor.cgColor
            cell.contentView.layer.borderWidth = 2.0
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = images[indexPath.row - 1]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.presentImagePicker()
        }
    }
}

extension EventCreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            images.insert(pickedImage, at: 0)
            presenter.newImagePicked(pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}






