
import UIKit

class EventViewController: UIViewController, EventViewProtocol  {
        
    var presenter: EventPresenterProtocol!
    let configurator: EventConfiguratorProtocol = EventConfigurator()
    
    var event: Event?
    var images = Dictionary<Int, UIImage>()
    
    var textColor = UIColor.black
    
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
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .justified
        return textView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    var placesView = PlacesView()
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    init(eventID: Int) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        titleLabel.text = self.event?.name
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        
        if let hashtags = self.event?.hashtags, hashtags.count > 0 {
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
        
        descriptionTextView.text = event?.description
        descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 525).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        descriptionTextView.isScrollEnabled = false
        
        descriptionTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80).isActive = true
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
    
    override func viewDidAppear(_ animated: Bool) {
        placesView = PlacesView(frame: CGRect(x: 0, y: titleLabel.frame.maxY + 20, width: self.view.frame.width, height: 505.0))
        if !placesView.isDescendant(of: self.view) {
            scrollView.addSubview(placesView)
        }
        if let places = self.event?.places{
            placesView.setPlaces(places)
        }
        placesView.createFields()
        if let id = self.event?.id {
            presenter.getRole(inEvent: id)
        }
        
    }
    
    var buttonCallback: ((Int) -> Void) = {_ in }
    
    func addButton(withColor color: UIColor, title: String, callback: @escaping ((Int) -> Void)) {
        buttonCallback = callback
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        
        if !button.isDescendant(of: self.view) {
            self.view.addSubview(button)
        }
        
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        if #available(iOS 11.0, *) {
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        }
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        
//        buttonCallback(event?.id ?? 1)
    }
    
    @objc func pressButton() {
        if let id = self.event?.id {
            buttonCallback(id)
        }
        
    }
     

}


extension EventViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageHeight = 250
        if let image = self.images[indexPath.row] {
            return CGSize(width: CGFloat(imageHeight)*(image.size.width/image.size.height), height: CGFloat(imageHeight))
        }
        return CGSize(width: imageHeight, height: imageHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.event?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let url = URL(string: staticUrlAddress + (self.event?.images?[indexPath.row] ?? ""))

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
