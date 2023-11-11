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
    
    static func getChatsForUser(userID: String, onChange: @escaping (Result<[Chat], APIError>) -> Void) {
        let db = Firestore.firestore()
        let chatCollection = db.collection("users")
                                .document(userID)
                                .collection("chats")
        chatCollection.addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
            if let documents = querySnapshot?.documents {
                var chatList = [Chat]()
                print("received from db:")
                print(documents)
                for document in documents {
                    do {
                        let chatRef = try document.data(as: ChatReference.self)
                        print(chatRef)
                        print(chatRef.chat_id.documentID)
                        getChatById(chatID: chatRef.chat_id.documentID) { result in
                            switch result {
                            case .success(let chat):
                                print(chat)
                                chatList.append(chat)
                                break
                            case .failure(let error):
                                print(error.localizedDescription)
                                break
                            }
                        }
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
    
    static func getChatById(chatID: String, _ completion: @escaping (Result<Chat, APIError>) -> Void) {
        let db = Firestore.firestore()
        let chatRef = db.collection("chats").document(chatID)
        chatRef.getDocument { snapshot, error in
            if let document = snapshot, document.exists {
                print(document)
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
}

