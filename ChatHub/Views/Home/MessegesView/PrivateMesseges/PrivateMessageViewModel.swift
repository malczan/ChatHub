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
    private let user: User
    
    private let messagesRelay = BehaviorRelay<[MessageModel]?>(value: nil)
    private let newMessageRelay = PublishRelay<MessageModel>()
    
    init(outputRelay: PublishRelay<Void>,
         services: ServicesContainer,
         user: User) {
        self.outputRelay = outputRelay
        self.services = services
        self.user = user
        fetchMessages()
    }
    
    var messageDriver: Driver<[MessageModel]?> {
        return messagesRelay.asDriver(onErrorDriveWith: Driver.never())
    }
    
    var newMessageDriver: Driver<MessageModel> {
        return newMessageRelay.asDriver(onErrorDriveWith: Driver.never())
    }
    
    struct MessageModel: Hashable {
        let message: String?
        let fromCurrentUser: Bool
    }
    
    var headerTitle: String {
        return user.username
    }
    
    var headerAvatarUrl: String? {
        return user.profileImageUrl
    }
    
    func goBackTapped() {
        outputRelay.accept(())
    }
    
    func send(message: String?) {
        guard let message = message else {
            return
        }

        services.messageService.sendMessage(
            to: user,
            text: message)
        
        newMessageSend(text: message)
    }
    
    private func fetchMessages() {
        services.messageService
            .fetchMessages(from: user)
            .subscribe(onNext: {
            [weak self] in
                self?.handleReceived(messages: $0)
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
                    message: message?.text,
                    fromCurrentUser: message?.fromId == userId ? true : false)
        })
    }
    
    private func newMessageSend(text: String) {
        newMessageRelay.accept(MessageModel(
            message: text,
            fromCurrentUser: true))
    }
    
}
