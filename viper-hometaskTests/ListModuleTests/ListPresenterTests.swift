@testable import viper_hometask
import XCTest

class ListPresenterTests: XCTestCase {
    private var testListPresenter: ListPresenterProtocol!
    private var listViewMock: ListMocks.ListViewMock!
    private var interactorMock: ListMocks.ListInteractorMock!
    private var listRouterMock: ListMocks.ListRouterMock!
    private var dataListMock: DataListProtocol!
    
    override func setUp() {
        dataListMock = ListMocks.DataListMock(
            list: ["abc", "def", "gh"])
        let listConfiguratorMock = ListMocks.ListConfiguratorMock()
        listViewMock = ListMocks.ListViewMock(
            configurator: listConfiguratorMock)
        
        listRouterMock = ListMocks.ListRouterMock()
        listRouterMock.viewController = listViewMock
        
        testListPresenter = ListPresenter(
            view: listViewMock,
            router: listRouterMock,
            dataList: dataListMock)
        
        interactorMock = ListMocks.ListInteractorMock(
            presenter: testListPresenter,
            networkServise: NetworkService())
        
        testListPresenter.interactor = interactorMock
    }

    override func tearDown() {
        testListPresenter = nil
        listViewMock = nil
        interactorMock = nil
        listRouterMock = nil
        dataListMock = nil
    }
    
    func test_notifyViewLoaded() {
        let expectation_fetchDataList = self.expectation(
            description: "fetchDataList is called when notifyViewLoaded")
        
        interactorMock.didCall_fetchDataList = {
            expectation_fetchDataList.fulfill()
        }
        
        testListPresenter.notifyViewLoaded()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberOrItems() {
        XCTAssertEqual(testListPresenter.numberOrItems(), dataListMock.randomList.count)
    }
    
    func test_itemAtIndexPath() {
        dataListMock.randomList.enumerated().forEach { (offset, element) in
            XCTAssertEqual(testListPresenter.item(at: IndexPath(row: offset, section: 0)), element)
        }
    }
    
    func test_dataListFetched() {
        let expectation_reloadData = self.expectation(
            description: "reloadData is called when dataListFetched")
        
        listViewMock.didCall_reloadData = {
            expectation_reloadData.fulfill()
        }
        
        testListPresenter.dataListFetched(dataList: dataListMock.randomList)
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(testListPresenter.dataList.randomList, dataListMock.randomList)
    }
}
