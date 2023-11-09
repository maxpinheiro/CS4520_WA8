//
//  ViewController.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    let defaults = UserDefaults.standard
    let notificationCenter = NotificationCenter.default
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    var savedUserEmail: String?

    var chats = [Chat]()
    var accessToken: String?
    
    var chatListView = ChatListView()
        
    override func loadView() {
        view = chatListView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // handles whenever the authentication state is changed (sign in, sign out, register)
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.currentUser = nil
                self.defaults.set(nil, forKey: "userEmail")
                self.setupLeftBarButton(isLoggedin: false)
            } else {
                self.currentUser = user
                guard let userEmail = user!.email else {
                    return showErrorAlert("Could not obtain email from user", controller: self)
                }
                self.defaults.set(userEmail, forKey: "userEmail")
                self.fetchChats(userEmail)
                self.setupLeftBarButton(isLoggedin: true)
                self.setupRightBarButton()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Messages"
        
        // hide keyboard on tapping screen
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        addObservers()
        checkSavedUser()
    }
    
    func checkSavedUser() {
        let savedUserEmail = defaults.object(forKey: "userEmail") as! String?
        // fetch chats if logged in, otherwise redirect to login
        if let userEmail = savedUserEmail {
            return fetchChats(userEmail)
        }
        return openLoginPage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func openLoginPage() {
        let loginController = LoginViewController()
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    
    func fetchChats(_ userEmail: String) {
        print("fetching chats for email \(userEmail)")
    }
    
    func addObservers() {
        notificationCenter.addObserver(
            self,
            selector: #selector(onLogoutSuccessful(notification:)),
            name: .logoutSuccessful,
            object: nil
        )
    }
    
    @objc func onLogoutSuccessful(notification: Notification) {
        openLoginPage()
    }

    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }

}
