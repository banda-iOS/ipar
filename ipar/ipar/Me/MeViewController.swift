
import UIKit

protocol MeVCDelegate:class {
    func sessionFinished()
}

class MeViewController: UIViewController, MeViewProtocol {

    var tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    let imagePicker = UIImagePickerController()
    
    @IBOutlet private weak var avatarImageButton: UIButton!
    weak var delegate: MeVCDelegate?
    
    override func loadView() {
        super.loadView()
        self.setupTable()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        self.view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.avatarImageButton.bottomAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        tableView.register(UINib(nibName: "MeTableViewCell", bundle: nil), forCellReuseIdentifier: "MeTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    private func administrationCellPressed() {
        print("administrationCellPressed")
    }
    
    private func favoritesCellPressed() {
        print("favoritesCellPressed")
    }
    
    private func userInfoCellPressed() {
        print("userInfoCellPressed")
    }
    
    private func signOutCellPressed() {
        presenter.showSignOutAlert()
        tableView.deselectAllRows()
    }
    
    var presenter: MePresenterProtocol!
    let configurator: MeConfiguratorProtocol = MeConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
       
        avatarImageButton.setImage(UIImage(named: "unselectedMe")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.view.backgroundColor = .groupedBackground
        
        
        avatarImageButton.layer.borderWidth = 1
        avatarImageButton.layer.borderColor = UIColor.backgroundRed.cgColor
        avatarImageButton.layer.masksToBounds = false
        avatarImageButton.layer.cornerRadius = avatarImageButton.frame.height/2
        avatarImageButton.clipsToBounds = true
        
        imagePicker.delegate = self
        
        presenter.getUserInfo()
    }
    
    
    
    func showAlert(_ alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setNavigationItemTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    func setAvatar(_ image: UIImage) {
        avatarImageButton.setImage(image, for: .normal)
    }
    
    func closeVC() {
        self.delegate?.sessionFinished()
    }
     
    @IBAction func avatarImageButtonPressed(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension MeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                case 0:
                    self.administrationCellPressed()
                case 1:
                    self.favoritesCellPressed()
                default:
                    return
            }
        case 1:
            switch indexPath.row {
                case 0:
                    self.userInfoCellPressed()
                case 1:
                    self.signOutCellPressed()
                default:
                    return
            }
        default:
            return
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as? UITableViewHeaderFooterView
        headerView!.textLabel!.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return NSLocalizedString("Event management", comment: "Event management section")//"Управление мероприятиями"
        case 1:
            return NSLocalizedString("Account management", comment: "Account management section")//"Управление аккаунтом"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeTableViewCell", for: indexPath) as! MeTableViewCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                case 0:
                    cell.label.text = NSLocalizedString("Administration", comment: "Administration cell")//"Администрирование"
                case 1:
                    cell.label.text = NSLocalizedString("Favourites", comment: "Favourites cell")//"Избранное"
                default:
                    cell.label.text = ""
            }
        case 1:
            switch indexPath.row {
                case 0:
                    cell.label.text = NSLocalizedString("Info about user", comment: "Info about user")//"Информация о пользователе"
                case 1:
                    cell.label.textColor = .red
                    cell.label.text = NSLocalizedString("Quit", comment: "Quit button")//"Выйти"
                default:
                    cell.label.text = ""
            }
        default:
            cell.label.text = ""
        }
        return cell
    }
    
    
}


extension MeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            avatarImageButton.contentMode = .scaleAspectFit
            avatarImageButton.setImage(pickedImage, for: .normal)
            uploadImage(pickedImage, path: "avatar", multipartName: "avatar", method: .put)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}


