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
import RxRelay

final class ConcreteUserService {
    
    let activeSession: Bool
    let userSession: FirebaseAuth.User?
    let user = PublishRelay<User>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.activeSession = (Auth.auth().currentUser != nil)
        self.userSession = Auth.auth().currentUser
    }
    
    func refreshUserInfo() {
        fetchUserInformation()
            .subscribe(onNext: { [weak self] in
                self?.user.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchUserInformation() -> Observable<User> {
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

