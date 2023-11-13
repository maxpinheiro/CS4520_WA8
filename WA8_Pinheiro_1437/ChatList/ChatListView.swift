//
//  ChatListView.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import UIKit

class ChatListView: UIView {
    var chatTableView: UITableView!

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
    
    func setupComponents() {
        setupChatTableView()
    }
    
    func setupChatTableView() {
        chatTableView = UITableView()
        chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "chats")
        addComponent(chatTableView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // chat table view
            chatTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            chatTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            chatTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            chatTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
