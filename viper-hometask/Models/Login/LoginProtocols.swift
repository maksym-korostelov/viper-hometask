import Foundation

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol! { get set }
    var configurator: LoginConfiguratorProtocol { get set }
    func updateErrorMessage(with message: String?)
    func showListScene()
}

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol! { set get }
    var interactor: LoginInteractorProtocol! { set get }
    var router: LoginRouterProtocol { get }
    func configureView()
    func setErrorMessage(_ message: String?)
    func passwordDidChange(_ newValue: String)
    func userNameDidChange(_ newValue: String)
    func loginButtonClicked()
    func userLoggedInSuccessfully()
}

protocol LoginInteractorProtocol: class {
    var presenter: LoginPresenterProtocol! { get }
    var networkServise: NetworkService { get }
    var userAccount: UserAccountProtocol { get }
    func loginUser()
    func passwordDidChange(_ newValue: String)
    func userNameDidChange(_ newValue: String)
}

protocol LoginRouterProtocol: class {
    var viewController: LoginViewProtocol! { get }
    func showListScene()
}

protocol LoginConfiguratorProtocol: class {
    func configure(with viewController: LoginViewProtocol)
}
