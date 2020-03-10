@testable import viper_hometask
import Foundation

enum ListMocks {
    final class MockNetworkService: NetworkService {
        override func requestData(url _: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
            let str = "abc\ndef\ngh\n"
            guard let data = str.data(using: .utf8) else {
                completionHandler(.failure(NSError()))
                return
            }
            completionHandler(.success(data))
        }
    }
    
    final class DataListMock : DataListProtocol {
        var randomList: [String]
        
        required init(list: [String]) {
            randomList = list
        }
    }
    
    final class ListInteractorMock: ListInteractorProtocol {
        // MARK: Expectation callbacks
        var didCall_fetchDataList: (() -> Void)?
        
        var presenter: ListPresenterProtocol!
        var networkServise: NetworkService
        
        required init(
            presenter: ListPresenterProtocol,
            networkServise: NetworkService) {
            
            self.presenter = presenter
            self.networkServise = networkServise
        }
        
        func fetchDataList() {
            didCall_fetchDataList?()
        }
    }
    
    final class ListRouterMock: ListRouterProtocol {
        var viewController: ListViewProtocol!
    }
    
    final class ListConfiguratorMock: ListConfiguratorProtocol {
        func configure(with viewController: ListViewProtocol) {
            
        }
    }
    
    final class ListViewMock: ListViewProtocol {
        // MARK: Expectation callbacks
        var didCall_reloadData: (() -> Void)?
                
        var presenter: ListPresenterProtocol!
        var configurator: ListConfiguratorProtocol
        
        init(configurator: ListConfiguratorProtocol) {
            self.configurator = configurator
        }
        
        func reloadData() {
            didCall_reloadData?()
        }
    }
    
    final class ListPresenterMock: ListPresenterProtocol {
        // MARK: Expectation callbacks
        var didCall_setErrorMessage: ((String?) -> Void)?
        var didCall_userLoggedInSuccessfully: (() -> Void)?
        var didCall_dataListFetched: (([String]) -> Void)?
        
        // MARK: ListPresenterProtocol
        var dataList: DataListProtocol
        var view: ListViewProtocol!
        var interactor: ListInteractorProtocol!
        var router: ListRouterProtocol
        
        required init(view: ListViewProtocol,
                      router: ListRouterProtocol,
                      dataList: DataListProtocol) {
            self.view = view
            self.router = router
            self.dataList = dataList
        }
        
        func notifyViewLoaded() {
            
        }
        
        func numberOrItems() -> Int {
            return 0
        }
        
        func item(at indexPath: IndexPath) -> String {
            return ""
        }
        
        func dataListFetched(dataList: [String]) {
            didCall_dataListFetched?(dataList)
        }
    }
}
