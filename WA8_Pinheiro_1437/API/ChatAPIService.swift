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
    case notFound
    case unknownError
    case networkError(message: String?)
    
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .notFound:
            return "Not found"
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
                        let chat = try document.data(as: Chat.self)
                        chatList.append(chat)
                    } catch {
                        onChange(.failure(.unknownError))
                    }
                }
                onChange(.success(chatList))
            }
        })
    }
    
    // fetch all chats that contain the provided user name
    static func getChatsWithUser(userName: String, completion: @escaping (Result<[Chat], APIError>) -> Void) {
        let db = Firestore.firestore()
        db.collection("chats").whereFilter(.orFilter([
            .whereField("source_user_name", isEqualTo: userName),
            .whereField("target_user_name", isEqualTo: userName)
        ])).getDocuments() { (snapshot, err) in
                if let err = err {
                    print(err)
                    completion(.failure(.unknownError))
                } else {
                    let documents = snapshot!.documents
                    let chats = documents.compactMap { document in
                        try? document.data(as: Chat.self)
                    }
                    completion(.success(chats))
                }
            }
    }
    
    static func getChatById(chatID: String, _ completion: @escaping (Result<Chat, APIError>) -> Void) {
        let db = Firestore.firestore()
        let chatRef = db.collection("chats").document(chatID)
        chatRef.getDocument { snapshot, error in
            if let document = snapshot, document.exists {
                do {
                    let chat = try document.data(as: Chat.self)
                    completion(.success(chat))
                } catch {
                    completion(.failure(.unknownError))
                }
            } else {
                completion(.failure(.notFound))
            }
        }
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
    
    // listens to a chat's messages for changes and invokes the callback each time the data changes
    static func getMesagesForChat(chatID: String, _ onChange: @escaping (Result<[Message], APIError>) -> Void) {
        let db = Firestore.firestore()
        let chatCollection = db.collection("chats")
                                .document(chatID)
                                .collection("messages")
                                .order(by: "timestamp")
        chatCollection.addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
            if let documents = querySnapshot?.documents {
                var messageList = [Message]()
                for document in documents {
                    do {
                        let message = try document.data(as: Message.self)
                        messageList.append(message)
                    } catch {
                        onChange(.failure(.unknownError))
                    }
                }
                onChange(.success(messageList))
            }
        })
    }
}

