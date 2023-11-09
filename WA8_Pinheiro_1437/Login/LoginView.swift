//
//  LoginView.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import UIKit

class LoginView: UIView {

    var emailInput: UITextField!
    var passwordInput: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    
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
        setupEmailInput()
        setupPasswordInput()
        setupLoginButton()
        setupSignupButton()
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
   
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.backgroundColor = .systemGray
        loginButton.tintColor = .white
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 6
        // padding
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        addComponent(loginButton)
    }
    
    func setupSignupButton() {
        signupButton = UIButton(type: .system)
        signupButton.tintColor = .darkGray
        signupButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.layer.cornerRadius = 6
        // padding
        signupButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        addComponent(signupButton)
    }
   
   func initConstraints() {
       NSLayoutConstraint.activate([
           // name input
           emailInput.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 64),
           emailInput.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
           emailInput.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
           emailInput.heightAnchor.constraint(equalToConstant: 60),
           // email input
           passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 24),
           passwordInput.leadingAnchor.constraint(equalTo: emailInput.leadingAnchor),
           passwordInput.trailingAnchor.constraint(equalTo: emailInput.trailingAnchor),
           passwordInput.heightAnchor.constraint(equalToConstant: 60),
           // login button
           loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 48),
           loginButton.leadingAnchor.constraint(equalTo: emailInput.leadingAnchor),
           loginButton.trailingAnchor.constraint(equalTo: emailInput.trailingAnchor),
           // signup button
           signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12),
           signupButton.leadingAnchor.constraint(equalTo: emailInput.leadingAnchor),
           signupButton.trailingAnchor.constraint(equalTo: emailInput.trailingAnchor)
       ])
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}
