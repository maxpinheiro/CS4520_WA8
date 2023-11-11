//
//  LoginViewController.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    var defaults = Defaults()

    let notificationCenter = NotificationCenter.default
    
    var loginView = LoginView()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        if (defaults.getKey(keyName: "currentUserID") != nil) {
            self.navigationController?.pushViewController(ViewController(), animated: true)
        }

        loginView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        loginView.signupButton.addTarget(self, action: #selector(onSignupButtonTapped), for: .touchUpInside)
        // remove back button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // hide keyboard when tapped outside
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onLoginButtonTapped() {
        // validate email field
        var email: String?
        if let emailText = loginView.emailInput.text {
            if emailText.isEmpty {
                return showErrorAlert("Email cannot be empty!", controller: self)
            } else if (!User.isValidEmail(emailText)) {
                return showErrorAlert("Email must be valid!", controller: self)
            } else {
                email = emailText
            }
        }
        // validate password field
        var password: String?
        if let passwordText = loginView.passwordInput.text {
            if passwordText.isEmpty {
                return showErrorAlert("Password cannot be empty!", controller: self)
            } else {
                password = passwordText
            }
        }
        attemptLogin(email!, password!)
    }
    
    func attemptLogin(_ email: String, _ password: String) {
        showActivityIndicator()
        AuthenticationAPIService.login(email, password) { result in
            switch result {
            case .success(_):
                //self.notificationCenter.post(name: .loginSuccessful, object: nil)
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated:  true)
                break
            case .failure(let error):
                self.hideActivityIndicator()
                showErrorAlert(error.localizedDescription, controller: self)
                break
            }
        }
    }
    
    @objc func onSignupButtonTapped() {
        let signupController = SignupViewController()
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(signupController, animated: true)
    }
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }

}
