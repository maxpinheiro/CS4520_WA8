//
//  ChatViewController.swift
//  WA8_Pinheiro_1437
//
//  Created by Lucy Bell on 11/11/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ChatViewController: UIViewController {
    let defaults = Defaults()
    let notificationCenter = NotificationCenter.default
    
    var chatScreen = ChatView()

    var chatDisplay: ChatDisplay?
    var messages = [Message]()
    
    var currentUserID: String?
    
    override func loadView() {
        view = chatScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = chatDisplay?.otherUsername
        
        chatScreen.messageTableView.delegate = self
        chatScreen.messageTableView.dataSource = self
        chatScreen.messageTableView.separatorStyle = .none
        
        //MARK: adding send behavior to send button
        chatScreen.sendButton.addTarget(self, action: #selector(onSendButtonTapped), for: .touchUpInside)
        
        if let userID = defaults.getKey(keyName: "currentUserID") {
            self.currentUserID = userID
        }
        if let uwChat = chatDisplay,
           let chatID = uwChat.chat.id {
            getMessagesForChat(chatID: chatID)
        }
        
        // hide keyboard when tapped outside
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onSendButtonTapped() {
        // if chat is empty
        if !chatScreen.textField.hasText {
            showErrorAlert("Chat cannot be empty", controller: self)
        } else {
            if let text = chatScreen.textField.text {
                createNewChat(text: text)
            } else {
                showErrorAlert("Invalid message", controller: self)
            }
        }
    }
    
    func createNewChat(text: String) {
        let db = Firestore.firestore()
        let currentDate = Date()
        let currentUserId = self.defaults.getKey(keyName: "currentUserID")!
        
        if let chatID = chatDisplay?.chat.id {
            db.collection("chats").document(chatID).collection("messages").addDocument(data:
                [
                    "text": text,
                    "timestamp": currentDate,
                    "user_id": currentUserId,
                ]
            )
            chatScreen.textField.text = ""
        }
    }
    
    func getMessagesForChat(chatID: String) {
        ChatAPIService.getMesagesForChat(chatID: chatID) { result in
            switch result {
            case .success(let messages):
                self.messages = messages
                self.chatScreen.messageTableView.reloadData()
                if !messages.isEmpty {
                    self.scrollToBottom()
                }
                break
            case .failure(let error):
                showErrorAlert(error.localizedDescription, controller: self)
                break
            }
        }
    }
    
    func scrollToBottom() {
        let numSections = chatScreen.messageTableView.numberOfSections
        let numRows = chatScreen.messageTableView.numberOfRows(inSection: numSections - 1)
        if numRows > 0 {
            let indexPath = IndexPath(row: numRows - 1, section: numSections - 1)
            chatScreen.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]

        // dequeue appropriate cell type based on message type
        let cell: MessageTableViewCell
        if currentUserID == message.user_id {
            cell = tableView.dequeueReusableCell(withIdentifier: "our-message", for: indexPath) as! OurMessageTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "their-message", for: indexPath) as! TheirMessageTableViewCell
        }

        cell.messageLabel.text = message.text
        cell.timeLabel.text = formatDate(date: message.timestamp, currDate: Date.now)
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        print(message)
    }
    
}
