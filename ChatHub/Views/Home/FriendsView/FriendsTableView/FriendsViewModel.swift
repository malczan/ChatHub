//
//  FriendsViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

final class FriendsViewModel {
    
    typealias ServicesContainer = UserServiceContainer
    
    let services: ServicesContainer
    
    init(services: ServicesContainer) {
        self.services = services
        fetchAllUsers()
    }
    
    let friendsSubject = BehaviorRelay<[FriendModel]?>(value: nil)
    private let disposeBag = DisposeBag()

    var friendsDriver: Driver<[FriendModel]?> {
        return friendsSubject.asDriver(onErrorDriveWith: Driver.never())
    }
        
    private func fetchAllUsers() {
        services
            .userService
            .fetchAllUsers()
            .subscribe(onNext: {
                [weak self] in
                self?.handleReceived(users: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleReceived(users: [User]) {
        
        friendsSubject.accept(
            users.map { user -> FriendModel in
            return FriendModel(
                nickname: user.username,
                photoUrl: user.profileImageUrl,
                friendStatus: checkUserRelationship(user))
        })
    }
    
    private func checkUserRelationship(_ user: User) -> FriendModel.FriendsStatus {
        guard let userId = services.userService.userSession?.uid else {
            return .stranger
        }
        if user.friends.contains(userId) {
            return .friend
        } else if user.requests.contains(userId) {
            return .pendingFriend
        } else if user.pending.contains(userId) {
            return .requestedFriend
        } else {
            return .stranger
        }
    }
}
