//
//  NewChatView.swift
//  WA8_Pinheiro_1437
//
//  Created by Lucy Bell on 11/9/23.
//

import UIKit

class NewChatView: UIView {

    var searchBar: UISearchBar!
    var tableViewSearchResults: UITableView!
    var bottomChatView: UIView!
    var sendChatLabel: UILabel!
    var textField: UITextField!
    var sendButton: UIButton!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setUpSearchBar()
        setUpSearchResults()
        setUpBottomChatView()
        setUpSendChatLabel()
        setUpTextField()
        setUpSendButton()
        
        initConstraints()
    }
    
    func setUpSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search for user.."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autocapitalizationType = .none
        self.addSubview(searchBar)
    }
    
    func setUpSearchResults() {
        tableViewSearchResults = UITableView()
        tableViewSearchResults.register(SearchTableViewCell.self, forCellReuseIdentifier: "users")
        tableViewSearchResults.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewSearchResults)
    }
    
    func setUpBottomChatView() {
        bottomChatView = UIView()
        bottomChatView.backgroundColor = .white
        bottomChatView.layer.cornerRadius = 6
        bottomChatView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomChatView.layer.shadowOffset = .zero
        bottomChatView.layer.shadowRadius = 4.0
        bottomChatView.layer.shadowOpacity = 0.7
        bottomChatView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomChatView)
    }
    
    func setUpSendChatLabel() {
        sendChatLabel = UILabel()
        sendChatLabel.text = "Send chat"
        sendChatLabel.font = .boldSystemFont(ofSize: 16)
        sendChatLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomChatView.addSubview(sendChatLabel)
    }
    
    func setUpTextField() {
        textField = UITextField()
        textField.placeholder = "Start typing your message..."
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        bottomChatView.addSubview(textField)
    }
    
    func setUpSendButton() {
        sendButton = UIButton(type: .system)
        sendButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        bottomChatView.addSubview(sendButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableViewSearchResults.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableViewSearchResults.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableViewSearchResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            tableViewSearchResults.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            
            //bottom chat view...
            bottomChatView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomChatView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomChatView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            sendButton.bottomAnchor.constraint(equalTo: bottomChatView.bottomAnchor, constant: -8),
            sendButton.leadingAnchor.constraint(equalTo: bottomChatView.leadingAnchor, constant: 4),
            sendButton.trailingAnchor.constraint(equalTo: bottomChatView.trailingAnchor, constant: -4),
            
            textField.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -8),
            textField.leadingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: -4),
            
            sendChatLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -8),
            sendChatLabel.centerXAnchor.constraint(equalTo: bottomChatView.centerXAnchor),
            
            bottomChatView.topAnchor.constraint(equalTo: sendChatLabel.topAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
