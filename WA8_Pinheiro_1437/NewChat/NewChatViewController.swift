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
    
    //MARK: CHANGE THIS! just for testing :)
    var namesDatabase = [
        "Marvin Cook","Samira Jimenez","Coral Hancock","Xander Wade","Terence Mcneil",
        "Dewey Buckley","Ophelia Higgins","Asiya Anthony","Francesco Knight",
        "Claude Gonzalez","Demi Decker","Casey Park","Jon Hendrix","Hope Harvey",
        "Richie Alexander","Carmen Proctor","Mercedes Callahan","Yahya Gibbs",
        "Julian Pittman","Shauna Ray"
    ]
    
    //MARK: the array to display the table view...
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
        
        //MARK: initializing the array for the table view with all the names...
        namesForTableView = namesDatabase
    }
    
    func fetchUsers() {
        let db = Firestore.firestore()
        
        let users = db.collection("users")

        users.getDocuments { (documents, error) in
          if let documents = documents {
              //let data = documents.map(doc => doc.data());

              //print("Data: \(data)")
          } else {
              print("Collection does not exist")
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
    
}

//MARK: adopting the search bar protocol...
extension NewChatViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            namesForTableView = namesDatabase
        }else{
            self.namesForTableView.removeAll()

            for name in namesDatabase{
                if name.contains(searchText){
                    self.namesForTableView.append(name)
                }
            }
        }
        self.newChatScreen.tableViewSearchResults.reloadData()
    }
}
