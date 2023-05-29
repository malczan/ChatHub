//
//  MessagesService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 24/05/2023.
//

import Foundation
import FirebaseFirestore
import RxSwift
import RxRelay

protocol MessageService {
    var newMessageRelay: BehaviorRelay<[Message]?> { get }
    var newRecentMessageRelay: BehaviorRelay<[Message]?> { get }
    func sendMessage(to friendId: String, text: String)
    func fetchMessages(from friendId: String) -> Observable<[Message?]>
    func fetchRecentSearches() -> Observable<[Message?]>
    func observeMessages(from friendId: String?)
    func observeRecentMessages()
}

protocol MessageServiceContainer {
    var messageService: MessageService { get }
}

final class ConcreteMessagesService: MessageService {
    
    let newMessageRelay = BehaviorRelay<[Message]?>(value: nil)
    let newRecentMessageRelay = BehaviorRelay<[Message]?>(value: nil)
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
        observeRecentMessages()
    }
    
    func sendMessage(to friendId: String, text: String) {
        guard let userId = userService.userSession?.uid else { return }
        let userRef = Firestore.firestore().collection("messages").document(userId).collection(friendId).document()
        let friendRef = Firestore.firestore().collection("messages").document(friendId).collection(userId)
        
        let recentUserRef = Firestore.firestore().collection("messages").document(userId).collection("recent-messages").document(friendId)
        let recentFriendRef = Firestore.firestore().collection("messages").document(friendId).collection("recent-messages").document(userId)
        
        let messageId = userRef.documentID
        
        let data: [String: Any] = ["text": text,
                                   "fromId": userId,
                                   "toId": friendId,
                                   "read": false,
                                   "timestamp": Timestamp(date: Date())]
        userRef.setData(data)
        friendRef.document(messageId).setData(data)
        
        recentUserRef.setData(data)
        recentFriendRef.setData(data)
        
    }
    
    func fetchMessages(from friendId: String) -> Observable<[Message?]> {
        return Observable.create { observer in
            guard let userId = self.userService.userSession?.uid else { return Disposables.create() }
            
            Firestore
                .firestore()
                .collection("messages")
                .document(userId)
                .collection(friendId)
                .order(by: "timestamp", descending: false)
                .getDocuments {
                    snapshot, error in
                    guard let documents = snapshot?.documents else { return }
                    let messages = documents.compactMap { try? $0.data(as: Message.self)}
                    observer.onNext(messages)
                    observer.onCompleted()
                }
            
            return Disposables.create()
        }
    }
    
    func observeMessages(from friendId: String?) {
        guard let userId = userService.userSession?.uid,
              let friendId = friendId else {
            return
        }
        
        Firestore
            .firestore()
            .collection("messages")
            .document(userId)
            .collection(friendId)
            .addSnapshotListener {
            [weak self] snapshot, _ in
                guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else {
                    return
                }
                let newMessages = changes.compactMap { try? $0.document.data(as: Message.self )}
                self?.newMessageRelay.accept(newMessages)
        }
    }
    
    func fetchRecentSearches() -> Observable<[Message?]> {
        return Observable.create { observer in
            guard let userId = self.userService.userSession?.uid else { return Disposables.create() }
            
            Firestore
                .firestore()
                .collection("messages")
                .document(userId)
                .collection("recent-messages")
                .order(by: "timestamp", descending: true)
                .getDocuments {
                    snapshot, error in
                    guard let documents = snapshot?.documents else { return }
                    let messages = documents.compactMap { try? $0.data(as: Message.self)}
                    observer.onNext(messages)
                    observer.onCompleted()
                }
            
            return Disposables.create()
        }
    }
    
    func observeRecentMessages() {
            guard let userId = self.userService.userSession?.uid else { return }
            
            Firestore
                .firestore()
                .collection("messages")
                .document(userId)
                .collection("recent-messages")
                .addSnapshotListener { snapshot, _ in
                    guard let changes = snapshot?.documentChanges.filter({$0.type == .added }) else {
                        return
                    }
                    let newRecentMessages = changes.compactMap { try? $0.document.data(as: Message.self )}
                    self.newRecentMessageRelay.accept(newRecentMessages)
                }
        
    }
}
    
