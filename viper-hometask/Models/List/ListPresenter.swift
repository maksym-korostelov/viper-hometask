import Foundation

final class ListPresenter: ListPresenterProtocol {
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
        interactor.fetchDataList()
    }
    
    func numberOrItems() -> Int {
        dataList.randomList.count
    }
    
    func item(at indexPath: IndexPath) -> String {
        dataList.randomList[indexPath.row]
    }
    
    func dataListFetched(dataList: [String]) {
        self.dataList.randomList = dataList
        view.reloadData()
    }
}
