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

    var chats = [Chat]()
    
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
        // fetch chats if logged in, otherwise redirect to login
        if let userID = savedUserID {
            self.currentUserID = userID
            return fetchChatsForUser(userID: userID)
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
    
    func fetchChatsForUser(userID: String) {
        print("fetching chats for user \(userID)")
        ChatAPIService.getChatsForUser(userID: userID, onChange: { result in
            switch result {
            case .success(let chats):
                print(chats)
                self.chats = chats
                self.chatListView.chatTableView.reloadData()
                break
            case .failure(let error):
                showErrorAlert(error.localizedDescription, controller: self)
                break
            }
        })
    }
    
    // given a user's email (firebase auth), get the corresponding
    // user in the firstore and save the user_id to cookies
    func fetchCurrentUser(_ userEmail: String) {
        AuthenticationAPIService.getUserByEmail(userEmail) { result in
            switch result {
            case .success(let user):
                self.defaults.setKey(key: user.id!, keyName: "currentUserID")
                self.fetchChatsForUser(userID: user.id!)
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
    
    func openChatDetailsPage(_ chat: Chat) {
        
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
        cell.label.text = chat.source_user_name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = chats[indexPath.row]
        openChatDetailsPage(chat)
    }
    
}

