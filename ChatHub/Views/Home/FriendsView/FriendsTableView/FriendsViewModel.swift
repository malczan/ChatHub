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
    
    typealias ServicesContainer =
    UserServiceContainer &
    DataObserverServiceContainer &
    FriendsServiceContainer
    
    typealias FriendStatus = FriendModel.FriendsStatus
    
    private let services: ServicesContainer
    private let outputRelay: PublishRelay<String?>
    
    init(services: ServicesContainer,
         outputRelay: PublishRelay<String?>) {
        self.services = services
        self.outputRelay = outputRelay
        fetchAllUsers()
        observeUpdates()
    }
    
    private let refreshSubject = PublishSubject<Void>()
    private let friendsRelay = BehaviorRelay<[FriendModel]?>(value: nil)
    private let disposeBag = DisposeBag()
    
    var refreshDriver: Driver<Void> {
        return refreshSubject.asDriver(onErrorDriveWith: Driver.never())
    }
    
    var strangerDriver: Driver<[FriendModel]?> {
        return friendsRelay
            .map({ $0?.filter({ $0.friendStatus == .stranger })})
            .asDriver(onErrorDriveWith: Driver.never())
    }

    var friendsDriver: Driver<[FriendModel]?> {
        return friendsRelay
            .map({ $0?.filter({ $0.friendStatus == .friend })})
            .asDriver(onErrorDriveWith: Driver.never())
    }
    
    var pendingRequestsDriver: Driver<[FriendModel]?> {
        return friendsRelay
            .map({ $0?.filter({ $0.friendStatus == .pendingFriend })})
            .asDriver(onErrorDriveWith: Driver.never())
    }

    var friendsRequestsDriver: Driver<[FriendModel]?> {
        return friendsRelay
            .map({ $0?.filter({ $0.friendStatus == .requestedFriend })})
            .asDriver(onErrorDriveWith: Driver.never())
    }
    
    func firstButtonTapped(_ friend: FriendModel?) {
        guard let friend = friend else {
            return
        }
        
        switch friend.friendStatus {
        case .stranger:
            outputRelay.accept(friend.user.id)
        case .requestedFriend:
            dismissRequest(friend)
        case .pendingFriend:
            outputRelay.accept(friend.user.id)
        case .friend:
            outputRelay.accept(friend.user.id)
        }
    }
    
    func secondButtonTapped(_ friend: FriendModel?) {
        guard let friend = friend else {
            return
        }
        
        switch friend.friendStatus {
        case .stranger:
            addFriendship(friend)
        case .requestedFriend:
            acceptFriendship(friend)
        case .pendingFriend:
            cancelRequest(friend)
        case .friend:
            deleteFriendship(friend)
        }
    }
    
    private func acceptFriendship(_ friend: FriendModel) {
        services
            .friendsService
            .accept(user: friend.user)
    }
    
    private func addFriendship(_ friend: FriendModel) {
        services
            .friendsService
            .add(user: friend.user)
    }
    
    private func deleteFriendship(_ friend: FriendModel) {
        services
            .friendsService
            .remove(user: friend.user)
    }
    
    private func cancelRequest(_ friend: FriendModel) {
        services
            .friendsService
            .cancelRequest(user: friend.user)
    }
    
    private func dismissRequest(_ friend: FriendModel) {
        services
            .friendsService
            .dismiss(user: friend.user)
    }

    private func fetchAllUsers() {
        refreshSubject.onNext(())
        
        services
            .userService
            .fetchAllUsers()
            .subscribe(onNext: {
                [weak self] in
                self?.handleReceived(users: $0)
            })
            .disposed(by: disposeBag)
    }
    
    func observeUpdates() {
        services
            .dataObserverService
            .userDataUpdatedRelay
            .skip(1)
            .subscribe(onNext: {
                [weak self] in
                self?.fetchAllUsers()
            })
            .disposed(by: disposeBag)
        
    }

    private func handleReceived(users: [User]) {
        
        friendsRelay.accept(
            users.map { user -> FriendModel in
            return FriendModel(
                user: user,
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
