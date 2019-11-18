
import Foundation
import Alamofire

class LoginInteractor: LoginInteractorProtocol {
    func login(userToLogin user: LoginUser) {
        uploadData(path: "login", method: .post, data: user, callback: loginRequestCallback)
    }
    
    var presenter: LoginPresenterProtocol!
    
    required init(presenter: LoginPresenterProtocol) {
       self.presenter = presenter
   	}
    
    
    func loginRequestCallback(response: DataResponse<Any>?) {
        if let response = response {
            if let headerFields = response.response?.allHeaderFields as? [String: String],
                       let URL = response.request?.url
                         {
                           let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
                           if cookies.count != 0 {
                               addSessionToKeychain(sessionid: cookies[0].value)
                           }
                         }
            
             switch response.result {
                case .success(let value):
                if let data = response.data {
                    print(response)
                    do {
                        let user: User = try JSONDecoder().decode(User.self, from: data)
                        presenter.creationFinishedWithSuccess(user: user)
                    } catch {
                        do {
                            let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
                            presenter.creationFinishedWithError(message: error.message)
                        } catch {
                            print("Can't decode error: \(data)")
                            return
                        }
                    }
                }
                
                 case .failure(let error):
                    presenter.creationFinishedWithError(message: "failure: \(error)")
                
            }
        }
    }
    
}

