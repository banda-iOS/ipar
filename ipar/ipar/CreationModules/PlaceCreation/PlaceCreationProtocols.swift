
import Foundation

protocol PlaceCreationViewProtocol: class{
    var presenter: PlaceCreationPresenterProtocol! { get set }
   
}

protocol PlaceCreationConfiguratorProtocol: class {
    func configure(with viewController: PlaceCreationViewProtocol)
}

protocol PlaceCreationPresenterProtocol: class {
	var view: PlaceCreationViewProtocol! {get set}
	
	
	var interactor: PlaceCreationInteractorProtocol! {get set}
	var router: PlaceCreationRouterProtocol! {get set}
   
}



protocol PlaceCreationInteractorProtocol: class {
	var presenter: PlaceCreationPresenterProtocol! { get set }
}
	
protocol PlaceCreationRouterProtocol: class {

}

