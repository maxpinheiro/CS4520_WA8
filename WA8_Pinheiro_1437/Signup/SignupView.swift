//
//  SignupView.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import UIKit

class SignupView: UIView {

    var nameInput: UITextField!
    var emailInput: UITextField!
    var passwordInput: UITextField!
    var passwordConfirmInput: UITextField!
    var signupButton: UIButton!
    var loginButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupComponents()
        initConstraints()
    }
    
    
    func addComponent(_ component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(component)
    }
    
    func addInputPadding(_ component: UITextField) {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        component.leftView = paddingView
        component.leftViewMode = .always
    }
    
    func setupComponents() {
        setupNameInput()
        setupEmailInput()
        setupPasswordInput()
        setupPasswordConfirmInput()
        setupSignupButton()
        setupLoginButton()
    }

    func setupNameInput() {
        nameInput = UITextField()
        nameInput.placeholder = "Username"
        nameInput.font = .systemFont(ofSize: 20)
        nameInput.keyboardType = .emailAddress
        nameInput.autocapitalizationType = .none
        nameInput.layer.borderWidth = 1
        nameInput.layer.borderColor = UIColor.systemGray.cgColor
        nameInput.layer.cornerRadius = 8
        addInputPadding(nameInput)
        addComponent(nameInput)
    }

    func setupEmailInput() {
        emailInput = UITextField()
        emailInput.placeholder = "Email"
        emailInput.font = .systemFont(ofSize: 20)
        emailInput.keyboardType = .emailAddress
        //emailInput.borderStyle = .roundedRect
        emailInput.autocapitalizationType = .none
        emailInput.layer.borderWidth = 1
        emailInput.layer.borderColor = UIColor.systemGray.cgColor
        emailInput.layer.cornerRadius = 8
        addInputPadding(emailInput)
        addComponent(emailInput)
    }
    
    func setupPasswordInput() {
        passwordInput = UITextField()
        passwordInput.placeholder = "Password"
        passwordInput.font = .systemFont(ofSize: 20)
        //passwordInput.borderStyle = .roundedRect
        passwordInput.autocapitalizationType = .none
        passwordInput.layer.borderWidth = 1
        passwordInput.layer.borderColor = UIColor.systemGray.cgColor
        passwordInput.layer.cornerRadius = 8
        addInputPadding(passwordInput)
        addComponent(passwordInput)
    }
    
    func setupPasswordConfirmInput() {
        passwordConfirmInput = UITextField()
        passwordConfirmInput.placeholder = "Confirm Password"
        passwordConfirmInput.font = .systemFont(ofSize: 20)
        //passwordInput.borderStyle = .roundedRect
        passwordConfirmInput.autocapitalizationType = .none
        passwordConfirmInput.layer.borderWidth = 1
        passwordConfirmInput.layer.borderColor = UIColor.systemGray.cgColor
        passwordConfirmInput.layer.cornerRadius = 8
        addInputPadding(passwordConfirmInput)
        addComponent(passwordConfirmInput)
    }
    
    func setupSignupButton() {
        signupButton = UIButton(type: .system)
        signupButton.backgroundColor = .systemGray
        signupButton.tintColor = .white
        signupButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.layer.cornerRadius = 6
        // padding
        signupButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        addComponent(signupButton)
    }
   
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.tintColor = .darkGray
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 6
        // padding
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        addComponent(loginButton)
    }
   
   func initConstraints() {
       NSLayoutConstraint.activate([
            // name input
            nameInput.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 64),
            nameInput.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            nameInput.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            nameInput.heightAnchor.constraint(equalToConstant: 60),
            // email input
            emailInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 24),
            emailInput.leadingAnchor.constraint(equalTo: nameInput.leadingAnchor),
            emailInput.trailingAnchor.constraint(equalTo: nameInput.trailingAnchor),
            emailInput.heightAnchor.constraint(equalToConstant: 60),
            // password input
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 24),
            passwordInput.leadingAnchor.constraint(equalTo: nameInput.leadingAnchor),
            passwordInput.trailingAnchor.constraint(equalTo: nameInput.trailingAnchor),
            passwordInput.heightAnchor.constraint(equalToConstant: 60),
            // password confirm input
            passwordConfirmInput.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 24),
            passwordConfirmInput.leadingAnchor.constraint(equalTo: nameInput.leadingAnchor),
            passwordConfirmInput.trailingAnchor.constraint(equalTo: nameInput.trailingAnchor),
            passwordConfirmInput.heightAnchor.constraint(equalToConstant: 60),
            // signup button
            signupButton.topAnchor.constraint(equalTo: passwordConfirmInput.bottomAnchor, constant: 48),
            signupButton.leadingAnchor.constraint(equalTo: nameInput.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: nameInput.trailingAnchor),
            // login button
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 12),
            loginButton.leadingAnchor.constraint(equalTo: nameInput.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: nameInput.trailingAnchor)
       ])
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
