
import Foundation
import UIKit

protocol MeViewProtocol: class{
    var presenter: MePresenterProtocol! { get set }
   
    func showAlert(_ alertController: UIAlertController)
    func setNavigationItemTitle(_ title: String)
    func setAvatar(_ image: UIImage)
    func closeVC()
}

protocol MeConfiguratorProtocol: class {
    func configure(with viewController: MeViewProtocol)
}

protocol MePresenterProtocol: class {
	var view: MeViewProtocol! {get set}

	var interactor: MeInteractorProtocol! {get set}
	var router: MeRouterProtocol! {get set}
    
    func getUserInfo()
    func presentUserInfo(aboutUser user: User)
    func presentUserImage(avatar: UIImage)
    
    func showSignOutAlert()
    
    func sessionFinished()
   
}



protocol MeInteractorProtocol: class {
	var presenter: MePresenterProtocol! { get set }
    
    func getUserInfo()
    
    func signOut()
}
	
protocol MeRouterProtocol: class {

}

