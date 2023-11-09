//
//  SignupViewController.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import UIKit

class SignupViewController: UIViewController {

    let notificationCenter = NotificationCenter.default
    
    var signupView = SignupView()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = signupView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"

        signupView.signupButton.addTarget(self, action: #selector(onSignupButtonTapped), for: .touchUpInside)
        signupView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // hide keyboard when tapped outside
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onSignupButtonTapped() {
        if let user = validUserInputs() {
            attemptSignup(user.name, user.email, user.password)
        }
    }
    
    // creates a user object from inputs, displaying an error if any fields are invalid
    func validUserInputs() -> User? {
        var name: String?
        if let nameText = signupView.nameInput.text {
            if nameText.isEmpty {
                showErrorAlert("Username cannot be empty.", controller: self)
                return nil
            } else {
                name = nameText
            }
        }
        var email: String?
        if let emailText = signupView.emailInput.text {
            if emailText.isEmpty {
                showErrorAlert("Email cannot be empty.", controller: self)
                return nil
            } else if (!User.isValidEmail(emailText)) {
                showErrorAlert("Email must be valid.", controller: self)
                return nil
            } else {
                email = emailText
            }
        }
        var password: String?
        if let passwordText = signupView.passwordInput.text {
            if passwordText.isEmpty {
                showErrorAlert("Password cannot be empty!", controller: self)
                return nil
            } else {
                password = passwordText
            }
        }
        guard let passwordConfirmText = signupView.passwordConfirmInput.text else {
            showErrorAlert("Password confirmation cannot be empty.", controller: self)
            return nil
        }
        if passwordConfirmText.isEmpty || password != passwordConfirmText {
            showErrorAlert("Passwords must match.", controller: self)
            return nil
        }
        return User(name: name!, email: email!, password: password!)
    }
    
    func attemptSignup(_ name: String, _ email: String, _ password: String) {
        showActivityIndicator()
        AuthenticationAPIService.signup(name, email, password) { result in
            switch result {
            case .success(_):
                //self.notificationCenter.post(name: .signupSuccessful, object: nil)
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
    
    @objc func onLoginButtonTapped() {
        let loginController = LoginViewController()
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }

}
