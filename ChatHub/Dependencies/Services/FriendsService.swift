//
//  FriendsService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import RxSwift

protocol FriendsService {
    
}

protocol FriendsServiceContainer {
    var friendsService: FriendsService { get }
}

final class ConcreteFriendsService: FriendsService {
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func add(user: User) {
        guard let uid = self.userService.userSession?.uid,
              let userUid = user.id
        else {
            return
        }
        let usersRef = Firestore.firestore().collection("users")
        
        usersRef.document(uid).updateData(
            ["pendingRequests": FieldValue.arrayUnion([userUid])])
        usersRef.document(userUid).updateData(
            ["friendRequests": FieldValue.arrayUnion([uid])])
    }
}
