import Foundation

final class LoginInteractor: LoginInteractorProtocol {
    weak var presenter: LoginPresenterProtocol!
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
        networkServise.requestLoginData(
            userName: userAccount.userName,
            password: userAccount.password) { [weak self] result in
                switch result {
                case .success:
                    print("login success")
                    self?.presenter.userLoggedInSuccessfully()
                case let .failure(error):
                    print("login failure")
                    self?.presenter.setErrorMessage(error.localizedDescription)
                }
            }
    }
    
    func passwordDidChange(_ newValue: String) {
        userAccount.password = newValue
    }
    
    func userNameDidChange(_ newValue: String) {
        userAccount.userName = newValue
    }
}
