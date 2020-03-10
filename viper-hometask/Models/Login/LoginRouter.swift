import Foundation

final class LoginRouter: LoginRouterProtocol {
    weak var viewController: LoginViewProtocol!
    
    init(viewController: LoginViewProtocol) {
        self.viewController = viewController
    }
    
    func showListScene() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewController.showListScene()
        }
    }
}
