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
    func sendMessage(to user: User, text: String)
    func fetchMessages(from user: User) -> Observable<[Message?]>
    func observeMessages(from user: User)
}

protocol MessageServiceContainer {
    var messageService: MessageService { get }
}

final class ConcreteMessagesService: MessageService {
    
    let newMessageRelay = BehaviorRelay<[Message]?>(value: nil)
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func sendMessage(to user: User, text: String) {
        guard let userId = userService.userSession?.uid else { return }
        guard let friendId = user.id else { return }
        let userRef = Firestore.firestore().collection("messages").document(userId).collection(friendId).document()
        let friendRef = Firestore.firestore().collection("messages").document(friendId).collection(userId)
        
        let messageId = userRef.documentID
        
        let data: [String: Any] = ["text": text,
                                   "fromId": userId,
                                   "toId": friendId,
                                   "read": false,
                                   "timestamp": Timestamp(date: Date())]
        userRef.setData(data)
        friendRef.document(messageId).setData(data)
    }
    
    func fetchMessages(from user: User) -> Observable<[Message?]> {
        return Observable.create { observer in
            guard let userId = self.userService.userSession?.uid else { return Disposables.create() }
            guard let friendId = user.id else { return Disposables.create() }
            
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
    
    func observeMessages(from user: User) {
        
        guard let userId = userService.userSession?.uid else {
            return
        }
        
        Firestore
            .firestore()
            .collection("messages")
            .document(userId)
            .collection("6EleCeRb0rZK2qvg8B2bUe6Tj0R2")
            .addSnapshotListener {
            [weak self] snapshot, _ in
                guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else {
                    return
                }
                let newMessages = changes.compactMap { try? $0.document.data(as: Message.self )}
                self?.newMessageRelay.accept(newMessages)
        }
    }
}
