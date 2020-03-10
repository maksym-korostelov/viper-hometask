@testable import viper_hometask
import Foundation

enum LoginMocks {
    final class MockNetworkService: NetworkService {
        override func requestLoginData(
            userName: String,
            password: String,
            completionHandler: @escaping (Result<Bool, LoginError>) -> Void
        ) {
            guard userName == "user", password == "password" else {
                completionHandler(.failure(LoginError.wrongCredentials))
                return
            }
            completionHandler(.success(true))
        }
    }
    
    final class LoginInteractorMock: LoginInteractorProtocol {
        // MARK: Expectation callbacks
        var didCall_passwordDidChange: ((String) -> Void)?
        var didCall_userNameDidChange: ((String) -> Void)?
        var didCall_loginUser: (() -> Void)?
        
        var presenter: LoginPresenterProtocol!
        var networkServise: NetworkService
        var userAccount: UserAccountProtocol
        
        required init(
            presenter: LoginPresenterProtocol,
            networkServise: NetworkService,
            userAccount: UserAccountProtocol) {
            
            self.presenter = presenter
            self.networkServise = networkServise
            self.userAccount = userAccount
        }
        
        func loginUser() {
            didCall_loginUser?()
        }
        
        func passwordDidChange(_ newValue: String) {
            didCall_passwordDidChange?(newValue)
        }
        
        func userNameDidChange(_ newValue: String) {
            didCall_userNameDidChange?(newValue)
        }
    }
    
    final class UserAccountMock: UserAccountProtocol {
        var userName: String = ""
        var password: String = ""
    }
    
    final class LoginRouterMock: LoginRouterProtocol {
        // MARK: Expectation callbacks
        var didCall_showListScene: (() -> Void)?
        
        var viewController: LoginViewProtocol!
        
        func showListScene() {
            didCall_showListScene?()
        }
    }
    
    final class LoginConfiguratorMock: LoginConfiguratorProtocol {
        func configure(with viewController: LoginViewProtocol) {
            
        }
    }
    
    final class LoginViewMock: LoginViewProtocol {
        // MARK: Expectation callbacks
        var didCall_showListScene: (() -> Void)?
        var didCall_updateErrorMessage: ((String?) -> Void)?
        
        func showListScene() {
            didCall_showListScene?()
        }
        
        var presenter: LoginPresenterProtocol!
        var configurator: LoginConfiguratorProtocol
        
        init(configurator: LoginConfiguratorProtocol) {
            self.configurator = configurator
        }
        
        func updateErrorMessage(with message: String?) {
            didCall_updateErrorMessage?(message)
        }
    }
    
    final class LoginPresenterMock: LoginPresenterProtocol {
        // MARK: Expectation callbacks
        var didCall_setErrorMessage: ((String?) -> Void)?
        var didCall_userLoggedInSuccessfully: (() -> Void)?
        
        // MARK: LoginPresenterProtocol
        var view: LoginViewProtocol!
        var interactor: LoginInteractorProtocol!
        var router: LoginRouterProtocol
        
        required init(view: LoginViewProtocol,
                      router: LoginRouterProtocol) {
            self.view = view
            self.router = router
        }
        
        func configureView() {
            
        }
        
        func setErrorMessage(_ message: String?) {
            didCall_setErrorMessage?(message)
        }
        
        func passwordDidChange(_ newValue: String) {
            
        }
        
        func userNameDidChange(_ newValue: String) {
            
        }
        
        func loginButtonClicked() {
            
        }
        
        func userLoggedInSuccessfully() {
            didCall_userLoggedInSuccessfully?()
        }
    }
}
