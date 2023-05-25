//
//  MessagesService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 24/05/2023.
//

import Foundation
import FirebaseFirestore

protocol MessageService {
    func sendMessage(to user: User, text: String)
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
}
