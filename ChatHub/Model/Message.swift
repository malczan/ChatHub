//
//  Message.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 24/05/2023.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable {
    @DocumentID var id: String?
    let fromId: String
    let toId: String
    let read: Bool
    let text: String
    let timestamp: Timestamp
}
