//
//  ChatView.swift
//  WA8_Pinheiro_1437
//
//  Created by Lucy Bell on 11/11/23.
//

import UIKit

class ChatView: UIView {
    
    var messageTableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
       
        setupComponents()
        initConstraints()
    }
    
    func addComponent(_ component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(component)
    }
    
    func setupComponents() {
        setupMessageTableView()
    }
    
    func setupMessageTableView() {
        messageTableView = UITableView()
        messageTableView.register(OurMessageTableViewCell.self, forCellReuseIdentifier: "our-message")
        messageTableView.register(TheirMessageTableViewCell.self, forCellReuseIdentifier: "their-message")
        addComponent(messageTableView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // chat table view
            messageTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            messageTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            messageTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            messageTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
