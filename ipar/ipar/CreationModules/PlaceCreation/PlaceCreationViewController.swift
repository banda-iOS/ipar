
import UIKit
import XLPagerTabStrip
import MapKit

protocol ObjectCreationDelegate: class {
    func objectCreated()
}

class PlaceCreationViewController: UIViewController, PlaceCreationViewProtocol, IndicatorInfoProvider  {

    weak var delegate: ObjectCreationDelegate?
    
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
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let addPositionButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Add geo position", comment: "Add geo position button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .backgroundRed
        button.addTarget(self, action: #selector(addPositionButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Create place", comment: "Place creation button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .midnightGreen
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
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
    
    let imagePicker = UIImagePickerController()
    var images = [UIImage]()
    
    var placemark: MKPlacemark? = nil
    
    let margin: CGFloat = 10
    var addPositionButtonTopAnchorConstraint: NSLayoutConstraint?
    var scrollBottomAnchorConstraint: NSLayoutConstraint?
    
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
        descriptionTextField.heightAnchor.constraint(equalToConstant: 650.0).isActive = true
        
        scrollView.addSubview(hashtagsTextField)

        hashtagsTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        hashtagsTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        hashtagsTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20.0).isActive = true
        hashtagsTextField.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        scrollView.addSubview(addPositionButton)

        addPositionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        addPositionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        addPositionButtonTopAnchorConstraint = addPositionButton.topAnchor.constraint(equalTo: hashtagsTextField.bottomAnchor, constant: 20.0)
        addPositionButtonTopAnchorConstraint?.isActive = true
        addPositionButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        scrollBottomAnchorConstraint = addPositionButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80.0)
        scrollBottomAnchorConstraint?.isActive = true
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    @objc func addPositionButtonPressed() {
        presenter.addPositionButtonPressed()
    }
    
    func userSelectedPlacemark(_ placemark: MKPlacemark, address: String) {
        presenter.parseAndSavePlacemarkAndAddress(placemark: placemark, address: address)
    }
    
    func getTitleField() -> String? {
        return self.titleTextField.text
    }
    
    func getDescriptionField() -> String {
        return self.descriptionTextField.text
    }
    
    func getHashtagsField() -> String {
        return self.hashtagsTextField.text
    }
    
    func getPlacemark() -> MKPlacemark? {
        return self.placemark
    }
    
    func createMapView() {
        addPositionButtonTopAnchorConstraint?.isActive = false
        
        scrollView.addSubview(mapView)
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        mapView.topAnchor.constraint(equalTo: hashtagsTextField.bottomAnchor, constant: 20.0).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        
        addPositionButtonTopAnchorConstraint = addPositionButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20.0)
        addPositionButtonTopAnchorConstraint?.isActive = true
        
        addPositionButton.titleLabel?.text = NSLocalizedString("Change geo position", comment: "Change geo position button")
    }
    
    func createConfirmButton() {
        scrollBottomAnchorConstraint?.isActive = false
        scrollView.addSubview(confirmButton)
        
        confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -margin).isActive = true
        confirmButton.topAnchor.constraint(equalTo: addPositionButton.bottomAnchor, constant: 20.0).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        scrollBottomAnchorConstraint = confirmButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80.0)
        scrollBottomAnchorConstraint?.isActive = true
    }
    
    func changePlacemarkOnMapView(_ placemark: MKPlacemark) {
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
       
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        self.placemark = placemark
    }
    
    @objc func confirmButtonPressed(){
        presenter.createPlace()
    }
    
    private func presentImagePicker() {
//        imagePicker.allowsEditing = true
//        imagePicker.sourceType = .photoLibrary
//
//        present(imagePicker, animated: true, completion: nil)
        let alert = UIAlertController(title: NSLocalizedString("Choose Image", comment: "Choose image title"), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: "Camera button"), style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("Gallery", comment: "Gallery button"), style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: NSLocalizedString("Cancel", comment: "Cancel button"), style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func hidePositionButton() {
        self.addPositionButton.removeFromSuperview()
    }
    
    func hideConfirmButton() {
        self.confirmButton.removeFromSuperview()
    }
    
    func makeHashtagsFieldUneditable() {
        self.hashtagsTextField.isEditable = false
    }
    
    func makeDescriptionFieldUneditable() {
        self.descriptionTextField.isEditable = false
    }
    
    func makeTitleFieldUneditable() {
        self.titleTextField.isUserInteractionEnabled = false
    }
    
    func createCollectionView() {
        scrollView.addSubview(collectionView)
        
        imagePicker.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        scrollBottomAnchorConstraint?.isActive = false
        
        scrollBottomAnchorConstraint = collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80.0)
    }
    
    func createDoneButton() {
        delegate?.objectCreated()
    }
}

extension PlaceCreationViewController: UITextViewDelegate {
    
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

extension PlaceCreationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
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

extension PlaceCreationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
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

extension PlaceCreationViewController {
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

