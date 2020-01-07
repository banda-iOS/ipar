
import UIKit
import Kingfisher
import MapKit

class PlaceViewController: UIViewController, PlaceViewProtocol  {

    
    var presenter: PlacePresenterProtocol!
    let configurator: PlaceConfiguratorProtocol = PlaceConfigurator()
    
    var place: Place?
    var images = Dictionary<Int, UIImage>()
    
    var textColor = UIColor.black
    
    weak var addPlaceDelegate: AddPlaceDelegate?
    
    let scrollView: UIScrollView = {
           let v = UIScrollView()
           v.translatesAutoresizingMaskIntoConstraints = false
           return v
    }()
    
    fileprivate let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        cv.backgroundColor = .none
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return cv
    }()
    
    fileprivate let tagsScrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "название места"
        return label
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .justified
        return textView
    }()
    
    let addPlaceButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Add place", comment: "Add place button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.0/255, green: 53.0/255, blue: 34.0/255, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    init(place: Place) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
    }
    
    init(placeID: Int) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(scrollView)
//        TODO: ситуация, когда нет фото
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0.0).isActive = true
        
        scrollView.addSubview(photosCollectionView)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        photosCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5).isActive = true
        photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        photosCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        photosCollectionView.showsHorizontalScrollIndicator = false
        
        
        scrollView.addSubview(titleLabel)
        titleLabel.text = self.place?.name
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        
        if let hashtags = self.place?.hashtags, hashtags.count > 0 {
            scrollView.addSubview(tagsScrollView)
            scrollView.showsVerticalScrollIndicator = false
            
            if #available(iOS 11.0, *) {
                tagsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            } else {
                tagsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            }
            tagsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            tagsScrollView.topAnchor.constraint(equalTo: photosCollectionView.bottomAnchor, constant: 5).isActive = true
            tagsScrollView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            tagsScrollView.showsHorizontalScrollIndicator = false
            
            var tagButtons = [UIButton]()
            
            for (i, hashtag) in hashtags.enumerated() {
                let button = UIButton()
                button.backgroundColor = .backgroundRed
                button.setTitle(" #\(hashtag) ", for: .normal)
                button.setTitleColor(self.textColor, for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.layer.cornerRadius = 5
                
                tagButtons.append(button)
                tagsScrollView.addSubview(button)
                
                if i == 0 {
                    button.leadingAnchor.constraint(equalTo: tagsScrollView.leadingAnchor, constant: 10).isActive = true
                } else {
                    button.leadingAnchor.constraint(equalTo: tagButtons[i - 1].trailingAnchor, constant: 5).isActive = true
                }
                button.centerYAnchor.constraint(equalTo: tagsScrollView.centerYAnchor).isActive = true
                if i == hashtags.count - 1 {
                    button.trailingAnchor.constraint(equalTo: tagsScrollView.trailingAnchor, constant: -10).isActive = true
                }
            }
            
            titleLabel.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: 5).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: photosCollectionView.bottomAnchor, constant: 5).isActive = true
        }
        
        scrollView.addSubview(descriptionTextView)
        
        descriptionTextView.text = place?.description
        descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        descriptionTextView.isScrollEnabled = false
        
        scrollView.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 5).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place?.latitude ?? 0.0, longitude: place?.longitude ?? 0.0)
        annotation.title = place?.name
        if let address = place?.address {
            annotation.subtitle = address
        }
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        mapView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80).isActive = true
        
        if let delegate = self.addPlaceDelegate {
            view.addSubview(addPlaceButton)
            
            addPlaceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            addPlaceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            if #available(iOS 11.0, *) {
                addPlaceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            } else {
                addPlaceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            }
            addPlaceButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
            
            addPlaceButton.addTarget(self, action: #selector(addPlaceToEvent), for: .touchUpInside)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        self.navigationController?.navigationBar.tintColor = self.textColor
    }
    
    @objc func addPlaceToEvent() {
        let addCommentVC = AddCommentViewController()
        addCommentVC.delegate = self
        present(addCommentVC, animated: true, completion: nil)
        blurEffectView.frame = view.bounds
        view.addSubview(self.blurEffectView)
    }
}

extension PlaceViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageHeight = 250
        if let image = self.images[indexPath.row] {
            return CGSize(width: CGFloat(imageHeight)*(image.size.width/image.size.height), height: CGFloat(imageHeight))
        }
        return CGSize(width: imageHeight, height: imageHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.place?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let url = URL(string: staticUrlAddress + (self.place?.images?[indexPath.row] ?? ""))

        let numOfImage = indexPath.row
        if let image = self.images[numOfImage] {
            cell.imageView.image = image
        } else {
            cell.imageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .cacheOriginalImage
                ])
            {
                image, error, cacheType, url in
                if let image = image {
                    
                    self.images[numOfImage] = image
                    collectionView.collectionViewLayout.invalidateLayout()
                }
            }
        }
        
        return cell
    }
}


extension PlaceViewController: AddCommentDelegate {
    func commentAdded(_ comment: String) {
        if let place = self.place {
            place.comment = comment
            self.addPlaceDelegate?.placeAdded(place)
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    func commentCancelled() {
        self.blurEffectView.removeFromSuperview()
    }
}


