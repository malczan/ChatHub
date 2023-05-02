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

protocol UserService {
    var activeSession: Bool { get }
    var userRelay: BehaviorRelay<User?> { get set }
    var userSession: FirebaseAuth.User? { get }
    func refreshUserInfo()
    func fetchOtherUser()
}

protocol UserServiceContainer {
    var userService: UserService { get }
}

final class ConcreteUserService: UserService {
    
    var userRelay = BehaviorRelay<User?>(value: nil)
    let activeSession: Bool
    let userSession: FirebaseAuth.User?
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.activeSession = (Auth.auth().currentUser != nil)
        self.userSession = Auth.auth().currentUser
        refreshUserInfo()
        fetchOtherUser()
    }
    
    func refreshUserInfo() {
        fetchUserInformation()
            .subscribe(onNext: {
                [weak self] in
                self?.userRelay.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchOtherUser() {
        fetchAllUsers()
            .subscribe(onNext: {
                [weak self] in
                print($0)
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
    
    private func fetchAllUsers() -> Observable<[User]> {
        return Observable.create { observer in
            Firestore.firestore().collection("users").getDocuments { snapshot, _ in
                
                guard let documents = snapshot?.documents else { return }
                let allUsers = documents.compactMap({ try? $0.data(as: User.self) })
                
                observer.onNext(allUsers)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

