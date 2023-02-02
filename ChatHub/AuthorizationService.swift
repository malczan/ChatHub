//
//  AuthorizationService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/02/2023.
//

import Foundation
import Firebase

protocol AuthorizationService {
    func signInUser()
    func signUpUser(with email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signOutUser()
}

final class ConcreteAuthorizationService: AuthorizationService {
    func signInUser() {
        //
    }
    
//    private func dupa(with email: String, password: String, completion:") {
//
//    }
    
    func signUpUser(with email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
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
