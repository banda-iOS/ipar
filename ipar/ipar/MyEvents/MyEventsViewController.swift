
import UIKit

class MyEventsViewController: UIViewController, MyEventsViewProtocol  {

    
    var presenter: MyEventsPresenterProtocol!
    let configurator: MyEventsConfiguratorProtocol = MyEventsConfigurator()
    
    let eventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "EventsSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "event")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        self.view.addSubview(eventsTableView)
               
        NSLayoutConstraint.activate([
           eventsTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
           eventsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
           eventsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           eventsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
           ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        self.navigationItem.title = NSLocalizedString("MY EVENTS", comment: "My events tab title")
        self.navigationController?.navigationBar.barTintColor = .backgroundRed
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getEvents()
    }
    
    func reloadData() {
        eventsTableView.reloadData()
    }
     

}

extension MyEventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getEventsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! EventsSearchTableViewCell
        let event = presenter.getEventBy(index: indexPath.row) as Event
        cell.eventTitleLabel.text = event.name
        cell.distanceToEventLabel.text = ""
        if  let images = event.images,
            images.count > 0{
            cell.eventImageView.kf.setImage(with: URL(string: staticUrlAddress + images[0]))
        } else {
            cell.eventImageView.kf.setImage(with: URL(string: "https://russiatrek.org/images/photo/vladimir-city-assumption-cathedral.jpg"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.eventCellWasSelectedWith(indexPathRow: indexPath.row)
    }

}


