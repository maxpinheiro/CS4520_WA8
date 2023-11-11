//
//  NavbarButtonManager.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import UIKit
import FirebaseAuth

extension ViewController {
    // displays login/logout button in navbar
    func setupLeftBarButton(isLoggedin: Bool) {
        if isLoggedin {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "person.fill.questionmark"),
                // title: "Login",
                style: .plain,
                target: self,
                action: #selector(onLoginButtonTapped)
            )
        }
    }
    
    func setupRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(onNewChatButtonTapped)
        )
    }
    
    @objc func onNewChatButtonTapped() {
        let newChatController = NewChatViewController()
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(newChatController, animated: true)
    }
    
    @objc func onLoginButtonTapped() {
        let loginController = LoginViewController()
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    
    @objc func onLogOutBarButtonTapped() {
        let logoutAlert = UIAlertController(title: "Confirm Logout", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: {(_) in
                do {
                    try Auth.auth().signOut()
                    self.notificationCenter.post(name: .logoutSuccessful, object: nil)
                } catch {
                    showErrorAlert("Error attempting to log out", controller: self)
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
    
}
