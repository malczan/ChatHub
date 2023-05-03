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
    func add(user: User)
    func remove(user: User)
    func accept(user: User)
    func dismiss(user: User)
    func cancelRequest(user: User)
}

protocol FriendsServiceContainer {
    var friendsService: FriendsService { get }
}

final class ConcreteFriendsService: FriendsService {
    
    private let userService: UserService
    private let usersRef = Firestore.firestore().collection("users")

    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func add(user: User) {
        guard let uid = self.userService.userSession?.uid,
              let userUid = user.id
        else {
            return
        }
        
        usersRef.document(uid).updateData(
            ["pending": FieldValue.arrayUnion([userUid])])
        usersRef.document(userUid).updateData(
            ["requests": FieldValue.arrayUnion([uid])])
    }
    
    func remove(user: User) {
        guard let uid = self.userService.userSession?.uid,
              let userUid = user.id
        else {
            return
        }
        
        usersRef.document(uid).updateData([
            "friends": FieldValue.arrayRemove([userUid])
        ])
        usersRef.document(userUid).updateData(
            ["friends": FieldValue.arrayRemove([uid])])
    }
    
    func accept(user: User) {
        guard let uid = self.userService.userSession?.uid,
              let userUid = user.id
        else {
            return
        }
        
        // delete from requests & pending
        usersRef.document(uid).updateData([
            "requests": FieldValue.arrayRemove([userUid])
        ])
        usersRef.document(userUid).updateData(
            ["pending": FieldValue.arrayRemove([uid])])
        
        // update both to friends
        usersRef.document(uid).updateData(
            ["friends": FieldValue.arrayUnion([userUid])])
        usersRef.document(userUid).updateData(
            ["friends": FieldValue.arrayUnion([uid])])
    }
    
    func dismiss(user: User) {
        guard let uid = self.userService.userSession?.uid,
              let userUid = user.id
        else {
            return
        }
        
        usersRef.document(uid).updateData([
            "requests": FieldValue.arrayRemove([userUid])
        ])
        usersRef.document(userUid).updateData(
            ["pending": FieldValue.arrayRemove([uid])])
    }

    func cancelRequest(user: User) {
        guard let uid = self.userService.userSession?.uid,
              let userUid = user.id
        else {
            return
        }
                
        usersRef.document(uid).updateData(
            ["pending": FieldValue.arrayRemove([userUid])])
        usersRef.document(userUid).updateData(
            ["requests": FieldValue.arrayRemove([uid])])
    }
}
