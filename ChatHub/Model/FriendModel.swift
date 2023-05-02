//
//  FriendModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import Foundation

struct FriendModel: Hashable {
    let nickname: String
    let photoUrl: String?
    let friendStatus: FriendsStatus
    
    enum FriendsStatus {
        case friend
        case pendingFriend
        case requestedFriend
        case stranger
    }
}
