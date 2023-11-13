//
//  NewChatViewController.swift
//  WA8_Pinheiro_1437
//
//  Created by Lucy Bell on 11/9/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class NewChatViewController: UIViewController {

    let defaults = Defaults()
    
    let newChatScreen = NewChatView()
    
    var userNames = [String]()
    
    var users = UserList(users: [])
    
    var namesForTableView = [String]()
    
    var selectedUser = User(name: "", email: "")
    
    override func loadView() {
        view = newChatScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create new chat"
        
        //MARK: getting the list of users
        self.fetchUsers()
        
        //MARK: setting up Table View data source and delegate...
        newChatScreen.tableViewSearchResults.delegate = self
        newChatScreen.tableViewSearchResults.dataSource = self
        
        //MARK: setting up Search Bar delegate...
        newChatScreen.searchBar.delegate = self
        
        //MARK: removing the seperator line
        newChatScreen.tableViewSearchResults.separatorStyle = .none
        
        //MARK: adding send behavior to send button
        newChatScreen.sendButton.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)
    }
    
    @objc func onSendButtonTapped() {
        // if no user is selected
        if selectedUser.name == "" {
            showErrorAlert("Must select a user to chat with", controller: self)
        // if chat is empty
        } else if !newChatScreen.textField.hasText {
            showErrorAlert("Chat cannot be empty", controller: self)
        } else {
            if let text = newChatScreen.textField.text {
                createNewChat(text: text)
            } else {
                showErrorAlert("Invalid message", controller: self)
            }
        }
    }
    
    func createNewChat(text: String) {
        let db = Firestore.firestore()
        var chatExists = false
        let currentDate = Date()
        let otherUserName = self.selectedUser.name
        let currentUserName = self.defaults.getKey(keyName: "currentUserName")!
        let currentUserId = self.defaults.getKey(keyName: "currentUserID")!
        
        db.collection("chats").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let chat = try document.data(as: Chat.self)
                        // checking if there is already an existing chat history
                        if (chat.source_user_name == currentUserName || chat.target_user_name == currentUserName)
                            && (chat.source_user_name == otherUserName || chat.target_user_name == otherUserName) {
                            chatExists = true
                            let id = chat.id!
                            db.collection("chats").document(id).collection("messages").addDocument(data: [
                                "text": text,
                                "timestamp": currentDate,
                                "user_id": currentUserId,
                            ])
                            let chatViewController = ChatViewController()
                            let chat = Chat(source_user_name: currentUserName, target_user_name: otherUserName)
                            chatViewController.chatDisplay = ChatDisplay(otherUsername: otherUserName, chat: chat)
                            self.navigationController?.pushViewController(chatViewController, animated: true)
                            break
                        }
                    } catch {
                        print(error)
                    }
                }
                // if there is no chat history, create a new chat
                if (!chatExists) {
                    let document = db.collection("chats").addDocument(data: [
                        "source_user_name": currentUserName,
                        "target_user_name": otherUserName,
                    ])
                    document.collection("messages").addDocument(data: [
                        "text": text,
                        "timestamp": currentDate,
                        "user_id": currentUserId,
                    ])
                    let chatViewController = ChatViewController()
                    let chat = Chat(source_user_name: currentUserName, target_user_name: otherUserName)
                    chatViewController.chatDisplay = ChatDisplay(otherUsername: otherUserName, chat: chat)
                    self.navigationController?.pushViewController(chatViewController, animated: true)
                }
            }
        }
    }
    
    func fetchUsers() {
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
              print("Error getting documents: \(err)")
            } else {
              for document in querySnapshot!.documents {
                  do {
                      let user = try document.data(as: User.self)
                      
                      // users cannot chat with their account
                      if user.id != self.defaults.getKey(keyName: "currentUserID") {
                          self.userNames.append(user.name)
                          self.users.users.append(user)
                      }
                  } catch {
                      print(error)
                  }
              }
              self.namesForTableView = self.userNames
              self.newChatScreen.tableViewSearchResults.reloadData()
            }
        }
    }
}

//MARK: adopting Table View protocols...
extension NewChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "users", for: indexPath) as! SearchTableViewCell
        
        cell.labelTitle.text = namesForTableView[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedUser = self.users.users[indexPath.row]
        self.newChatScreen.sendChatLabel.text = "Send chat to \(selectedUser.name)"
    }
}

//MARK: adopting the search bar protocol...
extension NewChatViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.namesForTableView = self.userNames
        }else{
            self.namesForTableView.removeAll()

            for name in self.userNames {
                if name.contains(searchText){
                    self.namesForTableView.append(name)
                }
            }
        }
        self.newChatScreen.tableViewSearchResults.reloadData()
    }
}
