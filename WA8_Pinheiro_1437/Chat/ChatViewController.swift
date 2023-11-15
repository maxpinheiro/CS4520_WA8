//
//  ChatViewController.swift
//  WA8_Pinheiro_1437
//
//  Created by Lucy Bell on 11/11/23.
//

import UIKit

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
        
        if let userID = defaults.getKey(keyName: "currentUserID") {
            self.currentUserID = userID
        }
        if let uwChat = chatDisplay,
           let chatID = uwChat.chat.id {
            getMessagesForChat(chatID: chatID)
        }
    }
    
    func getMessagesForChat(chatID: String) {
        print("getting messages for chat \(chatID)")
        ChatAPIService.getMesagesForChat(chatID: chatID) { result in
            switch result {
            case .success(let messages):
                print(messages)
                self.messages = messages
                self.chatScreen.messageTableView.reloadData()
                print(messages)
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
        DispatchQueue.main.async {
            if !self.messages.isEmpty {
                self.chatScreen.messageTableView.scrollToRow(
                    at: IndexPath(row: self.messages.count - 1, section: 0),
                    at: .bottom,
                    animated: true
                )
            }
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messages", for: indexPath) as! MessageTableViewCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = message.text
        cell.timeLabel.text = formatDate(date: message.timestamp, currDate: Date.now)
        cell.selectionStyle = .none
        
        // style based on whether message belongs to us or other user
        if currentUserID == message.user_id {
            print("our message")
            cell.messageWrapper.alignment = .trailing
            cell.messageBubble.backgroundColor = .systemBlue
            cell.messageBubble.layer.borderColor = UIColor.systemBlue.cgColor
            cell.messageLabel.textColor = .white
        } else {
            print("their message")
            cell.messageWrapper.alignment = .leading
            cell.messageBubble.backgroundColor = .systemGray5
            cell.messageBubble.layer.borderColor = UIColor.systemGray3.cgColor
            cell.messageLabel.textColor = .black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        print(message)
    }
    
}
