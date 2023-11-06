//
//  User.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import Foundation
import FirebaseFirestoreSwift

struct UserList: Codable {
    var users: [User]
}

struct User: Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
