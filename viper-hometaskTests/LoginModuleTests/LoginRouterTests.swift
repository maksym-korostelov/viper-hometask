@testable import viper_hometask
import XCTest

class LoginRouterTests: XCTestCase {
    
    func testShowListScene() {
        let loginConfiguratorMock = LoginMocks.LoginConfiguratorMock()
        let loginViewMock = LoginMocks.LoginViewMock(
            configurator: loginConfiguratorMock)
        
        let loginRouter = LoginRouter(viewController: loginViewMock)
        
        // MARK: Expectations
        let showListSceneExpectation = self.expectation(
            description: "showListScene is called on viewController")
        
        loginViewMock.didCall_showListScene = {
            showListSceneExpectation.fulfill()
        }
        
        loginRouter.showListScene()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
