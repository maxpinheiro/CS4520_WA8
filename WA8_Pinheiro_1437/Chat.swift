//
//  Chat.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Chat: Codable {
    @DocumentID var id: String?
    var user_ids: [String]
    
    init(user_ids: [String]) {
        self.user_ids = user_ids
    }
    
}
