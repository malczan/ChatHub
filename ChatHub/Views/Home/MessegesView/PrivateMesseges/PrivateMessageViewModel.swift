//
//  PrivateMessageViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 23/05/2023.
//

import Foundation
import RxRelay
import RxSwift
import Kingfisher

final class PrivateMesssageViewModel {
    
    typealias ServicesContainer =
    MessageServiceContainer
    
    private let outputRelay: PublishRelay<Void>
    private let services: ServicesContainer
    private let user: User
    
    
    init(outputRelay: PublishRelay<Void>,
         services: ServicesContainer,
         user: User) {
        self.outputRelay = outputRelay
        self.services = services
        self.user = user
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
    
}
