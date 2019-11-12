
import UIKit
import XLPagerTabStrip

class PlaceCreationViewController: UIViewController, PlaceCreationViewProtocol, IndicatorInfoProvider  {

    var itemInfo = IndicatorInfo(title: "View")

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
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
     

}


