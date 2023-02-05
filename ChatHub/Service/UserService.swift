//
//  UserService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import RxSwift

final class ConcreteUserService {
    
    let activeSession: Bool
    let userSession: FirebaseAuth.User?
    
    init() {
        self.activeSession = (Auth.auth().currentUser != nil)
        self.userSession = Auth.auth().currentUser
    }
    
    func fetchUserInformation() -> Observable<User> {
        return Observable.create { observer in
            guard let uid = self.userSession?.uid else { return Disposables.create() }
            
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
                guard let user = try? snapshot?.data(as: User.self) else { return }
                observer.onNext(user)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}

