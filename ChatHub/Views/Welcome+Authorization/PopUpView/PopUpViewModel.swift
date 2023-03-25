//
//  PopUpViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/02/2023.
//

import Foundation
import RxSwift
import RxRelay


class PopUpViewModel {
    
    let labelText: String
    let buttonInput = PublishSubject<Void>()
    
    private let outputRelay: PublishRelay<Void>
    
    init(error: Error,
         outputRelay: PublishRelay<Void>) {
        self.labelText = error.localizedDescription
        self.outputRelay = outputRelay
    }
    
    func buttonTapped() {
        outputRelay.accept(())
    }
    
}
