//
//  Chat.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import Foundation
import FirebaseFirestoreSwift

// lucy git test !! :)

struct Message: Codable {
    @DocumentID var id: String?
    var user_id: String
    var text: String
    var timestamp: String
    
    init(id: String? = nil, user_id: String, text: String, timestamp: String) {
        self.id = id
        self.user_id = user_id
        self.text = text
        self.timestamp = timestamp
    }
}

struct Chat: Codable {
    @DocumentID var id: String?
    var source_user_id: String?
    var target_user_id: String?
    
    init(source_user_id: String?, target_user_id: String?) {
        self.source_user_id = source_user_id
        self.target_user_id = target_user_id
    }
    
}
