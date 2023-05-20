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
    var dataUpdatedRelay: BehaviorRelay<Void> { get }
}

protocol DataObserverServiceContainer {
    var dataObserverService: DataObserverService { get }
}

final class ConcreteDataObserverService: DataObserverService {
    
    let dataUpdatedRelay = BehaviorRelay<Void>(value: Void())
    private let disposeBag = DisposeBag()
    
    
    init() {
        fetchDataChanges()
    }
    
    private let usersRef = Firestore.firestore().collection("users")
    
    private func fetchDataChanges() {
        usersRef.addSnapshotListener {
            [weak self] snapshot, _ in
            switch snapshot {
            case (.none):
                break
            case .some(_):
                self?.dataUpdatedRelay.accept(())
            }
        }
    }
}
