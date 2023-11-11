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

    let newChatScreen = NewChatView()
    
    var users = [String]()
    
    var usersTest = UserList(users: [])
    
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
                  let decoder = JSONDecoder()
                  let userData = document.data()
                  if let data = try? JSONSerialization.data(withJSONObject: userData, options: []) {
                      do {
                          let user = try decoder.decode(User.self, from: data)
                          // this works:
                          // let user = try decoder.decode(UserTest.self, from: data)
                          self.users.append(user.name)
                      } catch {
                          print(error)
                      }
                 }
              }
              self.namesForTableView = self.users
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
//        let package = self.notes[indexPath.row]
//        let detailsController = NoteDetailsViewController()
//        detailsController.receivedPackage = package
//        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}

//MARK: adopting the search bar protocol...
extension NewChatViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.namesForTableView = self.users
        }else{
            self.namesForTableView.removeAll()

            for name in self.users {
                if name.contains(searchText){
                    self.namesForTableView.append(name)
                }
            }
        }
        self.newChatScreen.tableViewSearchResults.reloadData()
    }
}
