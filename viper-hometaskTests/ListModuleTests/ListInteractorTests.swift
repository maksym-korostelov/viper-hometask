@testable import viper_hometask
import XCTest

class ListInteractorTests: XCTestCase {

    private var testInteractor: ListInteractor!
    private var userAccountMock: UserAccountProtocol!
    private var listPresenterMock: ListMocks.ListPresenterMock!
    private var dataListMock: DataListProtocol!
    
    override func setUp() {
        dataListMock = ListMocks.DataListMock(
        list: ["abc", "def", "gh"])
        let listConfiguratorMock = ListMocks.ListConfiguratorMock()
        let listViewMock = ListMocks.ListViewMock(
            configurator: listConfiguratorMock)
        
        let listRouterMock = ListMocks.ListRouterMock()
        listRouterMock.viewController = listViewMock
        
        listPresenterMock = ListMocks.ListPresenterMock(
            view: listViewMock,
            router: listRouterMock,
            dataList: dataListMock)
                
        testInteractor = ListInteractor(
            presenter: listPresenterMock,
            networkServise: ListMocks.MockNetworkService())
        
        listPresenterMock.interactor = testInteractor
    }
    
    override func tearDown() {
        testInteractor = nil
        userAccountMock = nil
        listPresenterMock = nil
        dataListMock = nil
    }
    
    func test_fetchDataList() {
        let expectation_dataListFetched = self.expectation(
            description: "dataListFetched is called on presenter when fetchDataList")
        
        listPresenterMock.didCall_dataListFetched = { _ in
            expectation_dataListFetched.fulfill()
        }
        
        testInteractor.fetchDataList()
        
        waitForExpectations(timeout: 1, handler: nil)
    }

}
