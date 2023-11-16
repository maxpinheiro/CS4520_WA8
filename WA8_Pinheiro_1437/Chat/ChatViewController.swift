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
