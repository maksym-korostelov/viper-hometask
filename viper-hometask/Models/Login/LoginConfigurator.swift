import Foundation

final class LoginConfigurator: LoginConfiguratorProtocol {
    
    func configure(with viewController: LoginViewProtocol) {
        let router = LoginRouter(
            viewController: viewController)
        let presenter = LoginPresenter(
            view: viewController,
            router: router)
        let interactor = LoginInteractor(
            presenter: presenter,
            networkServise: NetworkService(),
            userAccount: UserAccount())
        
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
