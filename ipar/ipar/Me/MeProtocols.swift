
import Foundation
import UIKit

protocol MeViewProtocol: class{
    var presenter: MePresenterProtocol! { get set }
   
    func showAlert(_ alertController: UIAlertController)
    func closeVC()
}

protocol MeConfiguratorProtocol: class {
    func configure(with viewController: MeViewProtocol)
}

protocol MePresenterProtocol: class {
	var view: MeViewProtocol! {get set}
	
	
	var interactor: MeInteractorProtocol! {get set}
	var router: MeRouterProtocol! {get set}
    
    func showSignOutAlert()
    
    func sessionFinished()
   
}



protocol MeInteractorProtocol: class {
	var presenter: MePresenterProtocol! { get set }
    
    func signOut()
}
	
protocol MeRouterProtocol: class {

}

