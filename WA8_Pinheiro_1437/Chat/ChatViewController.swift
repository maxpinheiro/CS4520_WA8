//
//  ChatViewController.swift
//  WA8_Pinheiro_1437
//
//  Created by Lucy Bell on 11/11/23.
//

import UIKit

class ChatViewController: UIViewController {
    
    var chatScreen = ChatView()
    var chatDisplay: ChatDisplay?
    
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = chatScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = chatDisplay?.otherUsername
    }
    
}
