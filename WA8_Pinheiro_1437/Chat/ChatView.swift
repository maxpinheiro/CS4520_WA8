//
//  ChatView.swift
//  WA8_Pinheiro_1437
//
//  Created by Lucy Bell on 11/11/23.
//

import UIKit

class ChatView: UIView {
    
    var messageTableView: UITableView!
    var bottomChatView: UIView!
    var textField: UITextField!
    var sendButton: UIButton!

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
        setUpBottomChatView()
        setUpTextField()
        setUpSendButton()
    }
    
    func setupMessageTableView() {
        messageTableView = UITableView()
        messageTableView.register(OurMessageTableViewCell.self, forCellReuseIdentifier: "our-message")
        messageTableView.register(TheirMessageTableViewCell.self, forCellReuseIdentifier: "their-message")
        addComponent(messageTableView)
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
    
    func setUpTextField() {
        textField = UITextField()
        textField.placeholder = "Start typing your message..."
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        bottomChatView.addSubview(textField)
    }
    
    func setUpSendButton() {
        sendButton = UIButton(type: .system)
        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        bottomChatView.addSubview(sendButton)
    }
    
    /*
     phoneNumberInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 16),
     phoneNumberInput.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 26),
     phoneNumberInput.trailingAnchor.constraint(equalTo: phoneTypeButton.leadingAnchor, constant: -16),
     
     phoneTypeButton.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 16),
     phoneTypeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -34),
     */
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // chat table view
            messageTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            messageTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            messageTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            messageTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            
            //bottom chat view...
            bottomChatView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomChatView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomChatView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            textField.topAnchor.constraint(equalTo: bottomChatView.topAnchor, constant: 4),
            textField.bottomAnchor.constraint(equalTo: bottomChatView.bottomAnchor, constant: -4),
            textField.leadingAnchor.constraint(equalTo: bottomChatView.leadingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -4),
            
            sendButton.topAnchor.constraint(equalTo: bottomChatView.topAnchor, constant: 4),
            sendButton.bottomAnchor.constraint(equalTo: bottomChatView.bottomAnchor, constant: -4),
            sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 4),
            sendButton.trailingAnchor.constraint(equalTo: bottomChatView.trailingAnchor, constant: -4),
            
            bottomChatView.topAnchor.constraint(equalTo: textField.topAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
