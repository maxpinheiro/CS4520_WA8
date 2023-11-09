//
//  AuthenticationAPIService.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import Foundation
import FirebaseAuth

struct AuthenticationResponse: Codable {
    let auth: Bool
    let token: String
}

enum AuthenticationAPIError: LocalizedError {
    case invalidUrl
    case invalidLogin
    case notFound
    case existingAccount
    case unknownError
    case authenticationError(message: String?)
    case networkError(message: String?)
    
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidLogin:
            return "Invalid username/password"
        case .notFound:
            return "Not found"
        case .existingAccount:
            return "User already exists"
        case .unknownError:
            return "Unknown error"
        case .authenticationError(let message):
            return message!
        case .networkError(let message):
            return message!
        }
    }
}

class AuthenticationAPIService {
    
    static func signup(_ name: String, _ email: String, _ password: String, _ completion: @escaping (Result<Bool, AuthenticationAPIError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            if error == nil {
                // set the name of the user after creating the account
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: {(error) in
                    if error == nil {
                        completion(.success(true))
                    } else {
                        print("Error occured: \(String(describing: error))")
                        completion(.failure(.unknownError))
                    }
                })
            } else {
                print(error)
                let errorMessage = error?.localizedDescription
                print(errorMessage)
                completion(.failure(.authenticationError(message: errorMessage)))
            }
        })
    }
    
    static func login(_ email: String, _ password: String, _ completion: @escaping (Result<Bool, AuthenticationAPIError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil {
                completion(.success(true))
            } else {
                completion(.failure(.invalidLogin))
            }
        })
    }
    
}

