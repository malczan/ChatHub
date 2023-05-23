//
//  MessegesViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import Foundation
import RxRelay

final class MessagesViewModel {
    // mocked
    var mockedMessegesList: [MessegePreviewModel] {
        return [MessegePreviewModel(senderName: "Jakub Malczyk", messegePreview: "Siema"),
                MessegePreviewModel(senderName: "Jakub Malczyk", messegePreview: "Hej"),
                MessegePreviewModel(senderName: "Jakub Malczyk", messegePreview: "Elo"),
                MessegePreviewModel(senderName: "Jakub Malczyk", messegePreview: "Jak leci?")]
    }
    
    struct MessegePreviewModel: Hashable {
        let senderName: String
        let messegePreview: String
    }
    //
    
    private let outputRelay: PublishRelay<Void>
    
    init(outputRelay: PublishRelay<Void>) {
        self.outputRelay = outputRelay
    }
    
    func chatSelected() {
        outputRelay.accept(())
    }
}
