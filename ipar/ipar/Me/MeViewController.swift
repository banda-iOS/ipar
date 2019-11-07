
import UIKit

protocol MeVCDelegate:class {
    func sessionFinished()
}

class MeViewController: UIViewController, MeViewProtocol {

    var tableView: UITableView = UITableView()
    
    @IBOutlet weak var avatarImageView: UIImageView!
    weak var delegate: MeVCDelegate?
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        self.view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 0.0),
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
        
//        avatarImageView.image = UIImage(named: "unselectedHome")
        self.navigationItem.title = "ФИО пользователя"
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemGroupedBackground
        } else {
            self.view.backgroundColor = UIColor(red: 238.0/255, green: 239.0/255, blue: 244.0/255, alpha: 1.0)
        }
        
        
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor(red: 232.0/255, green: 67.0/255, blue: 66.0/255, alpha: 1.0).cgColor
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.clipsToBounds = true
    }
    
    func showAlert(_ alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func closeVC() {
        self.delegate?.sessionFinished()
    }
     

}

extension MeViewController: UITableViewDelegate, UITableViewDataSource {

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
            return "Управление мероприятиями"
        case 1:
            return "Управление аккаунтом"
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
                    cell.label.text = "Администрирование"
                case 1:
                    cell.label.text = "Избранное"
                default:
                    cell.label.text = ""
            }
        case 1:
            switch indexPath.row {
                case 0:
                    cell.label.text = "Информация о пользователе"
                case 1:
                    cell.label.textColor = .red
                    cell.label.text = "Выйти"
                default:
                    cell.label.text = ""
            }
        default:
            cell.label.text = ""
        }
        return cell
    }
    
    
}


