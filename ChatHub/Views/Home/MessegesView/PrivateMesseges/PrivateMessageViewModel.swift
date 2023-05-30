//
//  PrivateMessageViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 23/05/2023.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift
import Kingfisher

final class PrivateMesssageViewModel {
    
    typealias ServicesContainer =
    MessageServiceContainer &
    UserServiceContainer
    
    private let disposeBag = DisposeBag()
    
    private let outputRelay: PublishRelay<Void>
    private let services: ServicesContainer
    private let userId: String
    
    private let messagesRelay = BehaviorRelay<[MessageModel]?>(value: nil)
    private let newMessageRelay = PublishRelay<[MessageModel]>()
    
    init(outputRelay: PublishRelay<Void>,
         services: ServicesContainer,
         userId: String) {
        self.outputRelay = outputRelay
        self.services = services
        self.userId = userId
        fetchMessages()
        observeMessages(from: userId)
    }
    
    var messageDriver: Driver<[MessageModel]?> {
        return messagesRelay.asDriver(onErrorDriveWith: Driver.never())
    }
    
    var newMessageDriver: Driver<[MessageModel]> {
        return newMessageRelay.asDriver(onErrorDriveWith: Driver.never())
    }
    
    struct MessageModel: Hashable {
        let id: String?
        let message: String?
        let fromCurrentUser: Bool
    }
    
    var userDriver: Driver<User> {
        return services
            .userService
            .fetchExactUser(id: userId)
            .asDriver(onErrorDriveWith: Driver.never())
    }
    
    func goBackTapped() {
        outputRelay.accept(())
    }
    
    func send(message: String?) {
        guard let message = message,
              message != "" else {
            return
        }
        
        services.messageService.sendMessage(
            to: userId,
            text: message)
    }
    
    private func fetchMessages() {
        services.messageService
            .fetchMessages(from: userId)
            .subscribe(onNext: {
                [weak self] in
                self?.handleReceived(messages: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func observeMessages(from user: String) {
        services.messageService
            .observeMessages(from: user)
        
        services
            .messageService
            .newMessageRelay
            .skip(2)
            .distinctUntilChanged()
            .subscribe(onNext: {
                [weak self] in
                self?.newMessageAppear(messages: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleReceived(messages: [Message?]) {
        guard let userId = services.userService.userSession?.uid else {
            return
        }
        
        messagesRelay.accept(messages
            .map { message -> MessageModel in
                return MessageModel(
                    id: UUID().uuidString,
                    message: message?.text,
                    fromCurrentUser: message?.fromId == userId ? true : false)
            })
    }
    
    
    private func newMessageAppear(messages: [Message]?) {
        guard let userId = services.userService.userSession?.uid,
              let messages = messages else {
            return
        }
        
        newMessageRelay.accept(messages
            .map { message -> MessageModel in
                return MessageModel(
                    id: UUID().uuidString,
                    message: message.text,
                    fromCurrentUser: message.fromId == userId ? true : false)
            })
    }
}
