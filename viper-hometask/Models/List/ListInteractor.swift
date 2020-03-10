import Foundation

final class ListInteractor: ListInteractorProtocol {
    var presenter: ListPresenterProtocol!
    var networkServise: NetworkService
    
    required init(presenter: ListPresenterProtocol,
                  networkServise: NetworkService) {
        self.presenter = presenter
        self.networkServise = networkServise
    }
    
    func fetchDataList() {
        networkServise.getRandomList { [weak self] result in
            switch result {
            case let .success(list):
                self?.presenter.dataListFetched(dataList: list)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
