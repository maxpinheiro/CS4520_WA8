//
//  ChatAPIService.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum APIError: LocalizedError {
    case invalidUrl
    case unknownError
    case networkError(message: String?)
    
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .unknownError:
            return "Unknown error"
        case .networkError(let message):
            return message!
        }
    }
}

class ChatAPIService {
    // listens to a document for changes and invokes the callback each time the data changes
    static func addChatListener(userEmail: String, _ onChange: @escaping (Result<[Chat], APIError>) -> Void) {
        let db = Firestore.firestore()
        let chatCollection = db.collection("users")
                                .document(userEmail)
                                .collection("chats")
        chatCollection.addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
            if let documents = querySnapshot?.documents {
                var chatList = [Chat]()
                for document in documents {
                    do {
                        let chat  = try document.data(as: Chat.self)
                        chatList.append(chat)
                    } catch {
                        onChange(.failure(.unknownError))
                    }
                }
                onChange(.success(chatList))
            }
        })
    }
    
    static func createChatForUser(userEmail: String, chat: Chat, _ completion: @escaping (Result<Bool, APIError>) -> Void) {
        let db = Firestore.firestore()
        let chatCollection = db.collection("users")
                                .document(userEmail)
                                .collection("chats")
        do {
            try chatCollection.addDocument(from: chat, completion: {(error) in
                if error == nil {
                    completion(.success(true))
                }
            })
        } catch {
            completion(.failure(.unknownError))
        }
    }
}

