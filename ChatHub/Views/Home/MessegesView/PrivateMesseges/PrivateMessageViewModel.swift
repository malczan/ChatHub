//
//  PrivateMessageViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 23/05/2023.
//

import Foundation
import RxRelay
import RxSwift

final class PrivateMesssageViewModel {
    
    private let outputRelay: PublishRelay<Void>
    
    init(outputRelay: PublishRelay<Void>) {
        self.outputRelay = outputRelay
    }
    
    func goBackTapped() {
        outputRelay.accept(())
    }
    
}
