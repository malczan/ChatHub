//
//  AuthorizationService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/02/2023.
//

import Foundation
import Firebase

protocol AuthorizationService {
    func signInUser(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUpUser(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signOutUser()
}

final class ConcreteAuthorizationService: AuthorizationService {
    
    func signInUser(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            guard error == nil else {
                guard let error = error else {
                    return
                }
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
        
    func signUpUser(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            guard error == nil else {
                guard let error = error else {
                    return
                }
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    func signOutUser() {
        //
    }
}
