import Foundation

final class ListRouter: ListRouterProtocol {
    var viewController: ListViewProtocol!
    
    init(viewController: ListViewProtocol) {
        self.viewController = viewController
    }
}
