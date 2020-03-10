import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var errorMessageLabel: UILabel!
    
    var presenter: LoginPresenterProtocol!
    var configurator: LoginConfiguratorProtocol = LoginConfigurator()
    
    let selfToListSegueName = "LoginToListSegue"
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        
        userNameField.addTarget(
            self,
            action: #selector(userNameFieldDidChange(_:)),
            for: UIControl.Event.editingChanged
        )
        passwordField.addTarget(
            self,
            action: #selector(passwordFieldDidChange(_:)),
            for: UIControl.Event.editingChanged
        )
    }
    
    // MARK: - Action methods
    
    @IBAction func loginButtonPressed(_: UIButton) {
        presenter.loginButtonClicked()
    }
    
    // MARK: LoginViewProtocol methods

    func updateErrorMessage(with message: String?) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.errorMessageLabel.isHidden = message?.isEmpty ?? true
            self.errorMessageLabel.text = message
        }
    }
    
    // MARK: TextField events
    
    @objc func userNameFieldDidChange(_ textField: UITextField) {
        presenter.userNameDidChange(textField.text ?? "")
    }

    @objc func passwordFieldDidChange(_ textField: UITextField) {
        presenter.passwordDidChange(textField.text ?? "")
    }
    
    func showListScene() {
        performSegue(withIdentifier: selfToListSegueName, sender: self)
    }
}
