import Foundation

protocol ListViewProtocol: class {
    var presenter: ListPresenterProtocol! { get set }
    var configurator: ListConfiguratorProtocol { get set }
    
    func reloadData()
}

protocol ListPresenterProtocol: class {
    var view: ListViewProtocol! { set get }
    var interactor: ListInteractorProtocol! { set get }
    var router: ListRouterProtocol { get }
    var dataList: DataListProtocol { get set }
    
    func notifyViewLoaded()
    func numberOrItems() -> Int
    func item(at indexPath: IndexPath) -> String
    func dataListFetched(dataList: [String])
}

protocol ListInteractorProtocol: class {
    var presenter: ListPresenterProtocol! { get }
    var networkServise: NetworkService { get }

    func fetchDataList()
}

protocol ListRouterProtocol: class {
    var viewController: ListViewProtocol! { get }
}

protocol ListConfiguratorProtocol: class {
    func configure(with viewController: ListViewProtocol)
}
