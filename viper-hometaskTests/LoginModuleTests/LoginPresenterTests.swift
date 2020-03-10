@testable import viper_hometask
import XCTest

class LoginPresenterTests: XCTestCase {
    var testLoginPresenter: LoginPresenterProtocol!
    var loginViewMock: LoginMocks.LoginViewMock!
    var interactorMock: LoginMocks.LoginInteractorMock!
    var loginRouterMock: LoginMocks.LoginRouterMock!

    override func setUp() {
        let loginConfiguratorMock = LoginMocks.LoginConfiguratorMock()
        loginViewMock = LoginMocks.LoginViewMock(
            configurator: loginConfiguratorMock)
        
        loginRouterMock = LoginMocks.LoginRouterMock()
        loginRouterMock.viewController = loginViewMock
        
        testLoginPresenter = LoginPresenter(
            view: loginViewMock,
            router: loginRouterMock)
        
        interactorMock = LoginMocks.LoginInteractorMock(
            presenter: testLoginPresenter,
            networkServise: NetworkService(),
            userAccount: UserAccount())
        
        testLoginPresenter.interactor = interactorMock
    }

    override func tearDown() {
        testLoginPresenter = nil
        loginViewMock = nil
        interactorMock = nil
        loginRouterMock = nil
    }
    
    func testConfigureView() {
        let expectation = self.expectation(
            description: "error message is set to nil on configuration stage")
        
        loginViewMock.didCall_updateErrorMessage = { message in
            if message == nil {
                expectation.fulfill()
            }
        }
        
        testLoginPresenter.configureView()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSetErrorMessage() {
        let expectedValue = "Some error message."
        let expectation = self.expectation(
            description: "error message is set")
        
        loginViewMock.didCall_updateErrorMessage = { message in
            if message == expectedValue {
                expectation.fulfill()
            }
        }
        
        testLoginPresenter.setErrorMessage(expectedValue)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testPasswordDidChange() {
        let expectedPassword = "Some password."
        let errorMessageExpectation = self.expectation(
            description: "error message is set to nil when password is changed")
        let passwordExpectation = self.expectation(
            description: "password did change was called on interactor")
        
        loginViewMock.didCall_updateErrorMessage = { message in
            if message == nil {
                errorMessageExpectation.fulfill()
            }
        }
        
        interactorMock.didCall_passwordDidChange = { password in
            if password == expectedPassword {
                passwordExpectation.fulfill()
            }
        }
        
        testLoginPresenter.passwordDidChange(expectedPassword)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserNamedDidChange() {
        let expectedUserName = "Some username."
        let errorMessageExpectation = self.expectation(
            description: "error message is set to nil when userName is changed")
        let userNameExpectation = self.expectation(
            description: "username did change was called on interactor")
        
        loginViewMock.didCall_updateErrorMessage = { message in
            if message == nil {
                errorMessageExpectation.fulfill()
            }
        }
        
        interactorMock.didCall_userNameDidChange = { userName in
            if userName == expectedUserName {
                userNameExpectation.fulfill()
            }
        }
        
        testLoginPresenter.userNameDidChange(expectedUserName)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoginButtonClicked() {
        let errorMessageExpectation = self.expectation(
            description: "error message is set to nil when login button clicked")
        let loginUserExpectation = self.expectation(
            description: "loginUser is called on interactor")
        
        loginViewMock.didCall_updateErrorMessage = { message in
            if message == nil {
                errorMessageExpectation.fulfill()
            }
        }
        
        interactorMock.didCall_loginUser = {
            loginUserExpectation.fulfill()
        }
        
        testLoginPresenter.loginButtonClicked()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserLoggedInSuccessfully() {
        let expectation = self.expectation(
            description: "userLoggedInSuccessfully is called on router")
        loginRouterMock.didCall_showListScene = {
            expectation.fulfill()
        }
        
        testLoginPresenter.userLoggedInSuccessfully()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
