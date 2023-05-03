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
    typealias FriendStatus = FriendModel.FriendsStatus
    
    let services: ServicesContainer
    
    init(services: ServicesContainer) {
        self.services = services
        fetchAllUsers()
    }
    
    let friendsSubject = BehaviorRelay<[FriendModel]?>(value: nil)
    private let disposeBag = DisposeBag()

    var friendsDriver: Driver<[FriendModel]?> {
        return friendsSubject
            .map({ $0?.filter({ $0.friendStatus == .friend })})
            .asDriver(onErrorDriveWith: Driver.never())
    }
    
    var pendingRequestsDriver: Driver<[FriendModel]?> {
        return friendsSubject
            .map({ $0?.filter({ $0.friendStatus == .pendingFriend })})
            .asDriver(onErrorDriveWith: Driver.never())
    }

    var friendsRequestsDriver: Driver<[FriendModel]?> {
        return friendsSubject
            .map({ $0?.filter({ $0.friendStatus == .requestedFriend })})
            .asDriver(onErrorDriveWith: Driver.never())
    }
    
    func firstButtonTapped(_ friendStatus: FriendStatus?) {
        switch friendStatus {
        case .stranger:
            print("messege")
        case .requestedFriend:
            print("Accept")
        case .pendingFriend:
            print("messege")
        case .friend:
            print("messege")
        case .none:
            break
        }
    }
    
    func secondButtonTapped(_ friendStatus: FriendStatus?) {
        switch friendStatus {
        case .stranger:
            print("add friend")
        case .requestedFriend:
            print("delete request")
        case .pendingFriend:
            print("messege")
        case .friend:
            print("remove friend")
        case .none:
            break
        }
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
