
import Foundation

protocol PlaceViewProtocol: class{
    var presenter: PlacePresenterProtocol! { get set }
   
}

protocol PlaceConfiguratorProtocol: class {
    func configure(with viewController: PlaceViewProtocol)
}

protocol PlacePresenterProtocol: class {
	var view: PlaceViewProtocol! {get set}
	
	
	var interactor: PlaceInteractorProtocol! {get set}
	var router: PlaceRouterProtocol! {get set}
   
}



protocol PlaceInteractorProtocol: class {
	var presenter: PlacePresenterProtocol! { get set }
}
	
protocol PlaceRouterProtocol: class {

}

