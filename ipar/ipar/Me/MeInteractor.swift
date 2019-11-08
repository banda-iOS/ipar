
import Foundation
import UIKit

class MeInteractor: MeInteractorProtocol {

    var presenter: MePresenterProtocol!
    private var user: User?
    
    required init(presenter: MePresenterProtocol) {
       self.presenter = presenter
   	}
    
    func getUserInfo() {
        let cachedUser = getUserFromKeychain()
        if let cachedUser = cachedUser {
            self.user = cachedUser
            if let avatarPath = cachedUser.avatarPath,
                avatarPath != "" {
                getImage(byPath: avatarPath, callback: currentImageCallback(image:))
            } else {
                getData(byPath: "me", callback: newUserInfoCallback(data:))
            }
            presenter.presentUserInfo(aboutUser: cachedUser)
        }
    }
    
    func currentImageCallback(image: UIImage) {
        presenter.presentUserImage(avatar: image)
        getData(byPath: "me", callback: newUserInfoCallback(data:))
    }
    
    
    func newUserInfoCallback(data: Data) {
        do {
            let user: User = try JSONDecoder().decode(User.self, from: data)
            if let cachedUser = self.user {
                if cachedUser.avatarPath != user.avatarPath,
                let avatar = user.avatarPath {
                    getImage(byPath: avatar, callback: newImageCallback(image:))
                }
                if !user.similarTo(user: cachedUser) {
                    addUserToKeychain(data)
                    presenter.presentUserInfo(aboutUser: user)
                }
            }
        } catch {
            
            do {
                let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
                print(error.message)
            } catch {
                print("Can't decode error")
                return
            }
            
        }
    }
    
    func newImageCallback(image: UIImage) {
        presenter.presentUserImage(avatar: image)
    }
    
    
    
    
    func signOut() {
        deleteSessionFromKeychain()
        
        presenter.sessionFinished()
    }
    
}

