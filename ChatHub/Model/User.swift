//
//  User.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let email: String
    let profileImageUrl: String?
    let friends: [String]
    let requests: [String]
    let pending: [String]
    
}
