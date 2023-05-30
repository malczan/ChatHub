//
//  DataObserverService.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/05/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import RxRelay
import RxSwift

protocol DataObserverService {
    var userDataUpdatedRelay: BehaviorRelay<Void> { get }
}

protocol DataObserverServiceContainer {
    var dataObserverService: DataObserverService { get }
}

final class ConcreteDataObserverService: DataObserverService {
    
    let userDataUpdatedRelay = BehaviorRelay<Void>(value: Void())
    let messagesDataUpdatedRelay = BehaviorRelay<Void>(value: Void())
    
    private let userService: UserService
    private let disposeBag = DisposeBag()
    
    
    init(userService: UserService) {
        self.userService = userService
        fetchUserDataChanges()
    }
    
    private func fetchUserDataChanges() {
        
        guard let userId = userService.userSession?.uid else {
            return
        }
        
        Firestore
            .firestore()
            .collection("users")
            .document(userId)
            .addSnapshotListener {
            [weak self] snapshot, _ in
            switch snapshot {
            case (.none):
                break
            case .some(_):
                self?.userDataUpdatedRelay.accept(())
            }
        }
    }
}
