//
//  ViewController.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    let defaults = Defaults()
    let notificationCenter = NotificationCenter.default
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentAuthUser: FirebaseAuth.User?
    var currentUserID: String?
    var currentUserName: String?

    var chats = [ChatDisplay]()
    
    var chatListView = ChatListView()
        
    override func loadView() {
        view = chatListView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // handles whenever the authentication state is changed (sign in, sign out, register)
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.currentAuthUser = nil
                self.defaults.setKey(keyName: "currentUserID")
                self.resetChatList()
                self.setupLeftBarButton(isLoggedin: false)
            } else {
                self.currentAuthUser = user
                guard let userEmail = user!.email else {
                    return showErrorAlert("Could not obtain email from user", controller: self)
                }
                self.fetchCurrentUser(userEmail)
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
        
        chatListView.chatTableView.delegate = self
        chatListView.chatTableView.dataSource = self
        chatListView.chatTableView.separatorStyle = .none
        
        addObservers()
        checkSavedUser()
    }

    func checkSavedUser() {
        let savedUserID = defaults.getKey(keyName: "currentUserID")
        let savedUserName = defaults.getKey(keyName: "currentUserName")
        // fetch chats if logged in, otherwise redirect to login
        if let userID = savedUserID,
           let userName = savedUserName {
            self.currentUserID = userID
            self.currentUserName = userName
            return fetchChatsForUser(userName: userName)
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
    
    func resetChatList() {
        self.chats = []
        self.chatListView.chatTableView.reloadData()
    }

    func fetchChatsForUser(userName: String) {
        ChatAPIService.getChatsWithUser(userName: userName) { result in
            switch result {
            case .success(let chats):
                self.chats = organizeChatsForUser(chats: chats, currentUserName: userName)
                self.chatListView.chatTableView.reloadData()
                break
            case .failure(let error):
                showErrorAlert(error.localizedDescription, controller: self)
                break
            }
        }
    }
    
    // given a user's email (firebase auth),
    // get the corresponding user in the firstore and save the userIdd and userName to cookies,
    // and fetch the chats for the user
    func fetchCurrentUser(_ userEmail: String) {
        AuthenticationAPIService.getUserByEmail(userEmail) { result in
            switch result {
            case .success(let user):
                self.defaults.setKey(key: user.id!, keyName: "currentUserID")
                self.defaults.setKey(key: user.name, keyName: "currentUserName")
                self.currentUserID = user.id!
                self.currentUserName = user.name
                self.fetchChatsForUser(userName: user.name)
                break
            case .failure(let error):
                showErrorAlert(error.localizedDescription, controller: self)
                break
            }
        }
    }
    
    func addObservers() {
        notificationCenter.addObserver(
            self,
            selector: #selector(onLogoutSuccessful(notification:)),
            name: .logoutSuccessful,
            object: nil
        )
    }
    
    func openChatDetailsPage(_ chat: ChatDisplay) {
        let chatController = ChatViewController()
        chatController.chatDisplay = chat
        self.navigationController?.pushViewController(chatController, animated: true)
    }
    
    @objc func onLogoutSuccessful(notification: Notification) {
        defaults.deleteKey(keyName: "currentUserID")
        openLoginPage()
    }

    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chats", for: indexPath) as! ChatTableViewCell
        let chat = chats[indexPath.row]
        cell.label.text = chat.otherUsername
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = chats[indexPath.row]
        openChatDetailsPage(chat)
    }
    
}

