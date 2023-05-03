//
//  FriendModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import Foundation

struct FriendModel: Hashable {
    let user: User
    let friendStatus: FriendsStatus
    
    enum FriendsStatus {
        case friend
        case pendingFriend
        case requestedFriend
        case stranger
    }
}
