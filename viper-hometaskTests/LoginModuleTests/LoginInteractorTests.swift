@testable import viper_hometask
import XCTest

class LoginInteractorTests: XCTestCase {
    private var testInteractor: LoginInteractor!
    private var userAccountMock: UserAccountProtocol!
    private var loginPresenterMock: LoginMocks.LoginPresenterMock!
    
    override func setUp() {
        let loginConfiguratorMock = LoginMocks.LoginConfiguratorMock()
        let loginViewMock = LoginMocks.LoginViewMock(
            configurator: loginConfiguratorMock)
        
        let loginRouterMock = LoginMocks.LoginRouterMock()
        loginRouterMock.viewController = loginViewMock
        
        loginPresenterMock = LoginMocks.LoginPresenterMock(
            view: loginViewMock,
            router: loginRouterMock)
        
        userAccountMock = LoginMocks.UserAccountMock()
        
        testInteractor = LoginInteractor(
            presenter: loginPresenterMock,
            networkServise: LoginMocks.MockNetworkService(),
            userAccount: userAccountMock)
        
        loginPresenterMock.interactor = testInteractor
    }
    
    override func tearDown() {
        testInteractor = nil
        userAccountMock = nil
        loginPresenterMock = nil
    }
    
    func testPasswordDidChange() {
        let expectedPassword = "Some password."
        
        testInteractor.passwordDidChange(expectedPassword)
        
        XCTAssertEqual(expectedPassword, userAccountMock.password)
    }
    
    func testUserNameDidChange() {
        let expectedUserName = "Some username."
        
        testInteractor.userNameDidChange(expectedUserName)
        
        XCTAssertEqual(expectedUserName, userAccountMock.userName)
    }
    
    func testLoginUserFailure() {
        let expectedErrorMessage = LoginError.wrongCredentials.errorDescription
        
        userAccountMock.userName = "wrong user"
        userAccountMock.password = "wrong password"
        
        let errorMessageExpectation = self.expectation(
            description: "error message is sent to presenter when login failed")
        
        let inverted_userLoggedInSuccessfullyExpectation = self.expectation(
            description: "userLoggedInSuccessfully is NOT called on presenter when login failed")
        inverted_userLoggedInSuccessfullyExpectation.isInverted = true
        
        loginPresenterMock.didCall_setErrorMessage = { message in
            if message == expectedErrorMessage {
                errorMessageExpectation.fulfill()
            }
        }
        
        loginPresenterMock.didCall_userLoggedInSuccessfully = {
            inverted_userLoggedInSuccessfullyExpectation.fulfill()
        }
        
        testInteractor.loginUser()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoginUserSuccess() {
        userAccountMock.userName = "user"
        userAccountMock.password = "password"
        
        let userLoggedInSuccessfullyExpectation = self.expectation(
            description: "userLoggedInSuccessfully is called on presenter when login successful")
        
        loginPresenterMock.didCall_userLoggedInSuccessfully = {
            userLoggedInSuccessfullyExpectation.fulfill()
        }
        
        testInteractor.loginUser()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
