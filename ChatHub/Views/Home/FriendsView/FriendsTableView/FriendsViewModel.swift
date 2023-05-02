//
//  FriendsViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import Foundation

final class FriendsViewModel {
    
    struct FriendModel: Hashable {
        let nickname: String
        let photoUrl: String
        let friendStatus: FriendsStatus
        
        enum FriendsStatus {
            case friend
            case pendingFriend
            case requestedFriend
            case stranger
        }
    }
    
    var mockedFriendsList: [FriendModel] {
        return [FriendModel(nickname: "Malczan", photoUrl: "", friendStatus: .friend),
                FriendModel(nickname: "Paniut", photoUrl: "", friendStatus: .stranger),
                FriendModel(nickname: "Krystian", photoUrl: "", friendStatus: .pendingFriend),
                FriendModel(nickname: "Krzysztof", photoUrl: "", friendStatus: .requestedFriend)]
    }
}
