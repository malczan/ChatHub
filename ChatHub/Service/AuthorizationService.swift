//
//  AuthorizationService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/02/2023.
//

import Foundation
import Firebase
import RxSwift

enum CustomErrors : Error {
    case somethingWentWrong
}

protocol AuthorizationService {
    func signInUser(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUpUser(withUsername username: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
//    func signOutUser()
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
        
    func signUpUser(withUsername username: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                guard let error = error else { return }
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user else {
                completion(.failure(CustomErrors.somethingWentWrong))
                return
            }
            
            let data: [String: Any] = ["username": username,
                                       "email": email]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                guard error == nil else {
                    guard let error = error else { return }
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }
        }
    }
    
    func signOutUser() -> Observable<Void> {
        return Observable.create { observer in
            do {
                try Auth.auth().signOut()
                observer.onNext(())
                observer.onCompleted()
            } catch let signOutError {
                observer.onError(signOutError)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
