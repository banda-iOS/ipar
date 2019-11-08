
import Foundation
import UIKit

class MePresenter: MePresenterProtocol {
    
    
    required init(view: MeViewProtocol) {
       self.view = view
    }
    
    
    var view: MeViewProtocol!
	
	
	var interactor: MeInteractorProtocol!
	var router: MeRouterProtocol!
    
    func getUserInfo() {
        interactor.getUserInfo()
    }
    
    func presentUserInfo(aboutUser user: User) {
        view.setNavigationItemTitle("\(user.surname) \(user.name)")
    }
    
    func presentUserImage(avatar: UIImage) {
        view.setAvatar(avatar)
    }
    
    
    func showSignOutAlert() {
        let alert = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Выйти", style: UIAlertAction.Style.destructive, handler: { action in
            self.interactor.signOut()
        }))
        view.showAlert(alert)
    }
    
    
    func sessionFinished() {
        view.closeVC()
    }
    
}

