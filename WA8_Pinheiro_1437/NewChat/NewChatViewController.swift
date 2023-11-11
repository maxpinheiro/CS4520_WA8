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
        let package = self.users.users[indexPath.row]
        let chatController = ChatViewController()
        chatController.receivedPackage = package
        self.navigationController?.pushViewController(chatController, animated: true)
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
