//
//  MessegesViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import Foundation

final class MessegesViewModel {
    struct MessegePreviewModel: Hashable {
        let senderName: String
        let messegePreview: String
    }
    
    init() {}
    
    var mockedMessegesList: [MessegePreviewModel] {
        return [MessegePreviewModel(senderName: "Jakub Malczyk", messegePreview: "Siema"),
                MessegePreviewModel(senderName: "Jakub Malczyk", messegePreview: "Hej"),
                MessegePreviewModel(senderName: "Jakub Malczyk", messegePreview: "Elo"),
                MessegePreviewModel(senderName: "Jakub Malczyk", messegePreview: "Jak leci?")]
    }
}
