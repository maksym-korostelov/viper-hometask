import Foundation

final class ListConfigurator: ListConfiguratorProtocol {
    func configure(with viewController: ListViewProtocol) {
        let router = ListRouter(
            viewController: viewController)
        let presenter = ListPresenter(
            view: viewController,
            router: router,
            dataList: DataList())
        let interactor = ListInteractor(
            presenter: presenter,
            networkServise: NetworkService())
        
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
