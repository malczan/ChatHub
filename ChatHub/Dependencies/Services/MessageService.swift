//
//  MessagesService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 24/05/2023.
//

import Foundation
import FirebaseFirestore
import RxSwift

protocol MessageService {
    func sendMessage(to user: User, text: String)
    func fetchMessages(from user: User) -> Observable<[Message?]>
}

protocol MessageServiceContainer {
    var messageService: MessageService { get }
}

final class ConcreteMessagesService: MessageService {
    
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
}
