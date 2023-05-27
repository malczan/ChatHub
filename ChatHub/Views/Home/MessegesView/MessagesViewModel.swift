//
//  MessegesViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import Foundation
import Firebase
import RxCocoa
import RxSwift
import RxRelay

final class MessagesViewModel {
    
    typealias ServicesContainer =
    MessageServiceContainer &
    UserServiceContainer
    
    private let services: ServicesContainer
    private let outputRelay: PublishRelay<Void>
    private let disposeBag = DisposeBag()
    private let recentMessagesRelay = BehaviorRelay<[MessegePreview]?>(value: nil)
    
    init(services: ServicesContainer,
         outputRelay: PublishRelay<Void>) {
        self.outputRelay = outputRelay
        self.services = services
        fetchRecentMessages()
    }
    
    var recentMessagesDriver: Driver<[MessegePreview]?> {
        return recentMessagesRelay.asDriver(onErrorDriveWith: Driver.never())
    }
    
    struct MessegePreview: Hashable {
        let userId: String?
        let message: String?
        let read: Bool?
        let timestamp: Timestamp?
        let sendByCurrentUser: Bool
    }
    
    
    func chatSelected() {
        outputRelay.accept(())
    }
    
    func getUserInfo(with id: String) -> Observable<User> {
        return services.userService.fetchExactUser(id: id)
    }
    
    private func fetchRecentMessages() {
        services
            .messageService
            .fetchRecentSearches()
            .subscribe(onNext: {
                [weak self] in
                self?.handleReceived(messages: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleReceived(messages: [Message?]) {
        
        let userService = services.userService
        
        recentMessagesRelay.accept(messages
            .map { message -> MessegePreview in
                return MessegePreview(
                    userId: message?.fromId == userService.userSession?.uid ? message?.toId : message?.fromId,
                    message: message?.text,
                    read: message?.read,
                    timestamp: message?.timestamp,
                    sendByCurrentUser: message?.fromId == userService.userSession?.uid ? true : false)
            })
    }
}
