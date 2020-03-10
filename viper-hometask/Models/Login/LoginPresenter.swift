import Foundation

final class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol!
    var interactor: LoginInteractorProtocol!
    var router: LoginRouterProtocol
    
    required init(view: LoginViewProtocol,
                  router: LoginRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func configureView() {
        setErrorMessage(nil)
    }
    
    func userNameDidChange(_ newValue: String) {
        setErrorMessage(nil)
        interactor.userNameDidChange(newValue)
    }

    func passwordDidChange(_ newValue: String) {
        setErrorMessage(nil)
        interactor.passwordDidChange(newValue)
    }
    
    func setErrorMessage(_ message: String?) {
        DispatchQueue.main.async { [weak view] in
            view?.updateErrorMessage(with: message)
        }
    }
    
    func loginButtonClicked() {
        setErrorMessage(nil)
        interactor.loginUser()
    }
    
    func userLoggedInSuccessfully() {
        router.showListScene()
    }
}
