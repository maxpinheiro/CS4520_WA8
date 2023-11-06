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
    var source_user_id: String?;
    var target_user_id: String?;
    
    init(source_user_id: String?, target_user_id: String?) {
        self.source_user_id = source_user_id
        self.target_user_id = target_user_id
    }
    
}
