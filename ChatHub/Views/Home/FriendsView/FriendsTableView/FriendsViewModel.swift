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
        
        let friend =
            users.map { users -> FriendModel in
            return FriendModel(
                nickname: users.username,
                photoUrl: users.profileImageUrl,
                friendStatus: .friend)
        }
        
        friendsSubject.accept(friend)
    }
    
}
