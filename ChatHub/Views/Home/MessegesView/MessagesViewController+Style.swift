//
//  MessegesViewController+Style.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import UIKit

enum MessagesViewStyle {
    static let avatarPlaceholder = UIImage(named: "avatar-placeholder")
    
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let purpleColor = UIColor(named: "purple")
    static let lightPurpleColor  = UIColor(named: "lightPurple")
    static let whiteColor = UIColor.white
    static let navigationControllerAttr = [NSAttributedString.Key.foregroundColor:UIColor(named: "purple") as Any]
    static let textFieldPlaceholderAttr = NSAttributedString(
        string: "Message...",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
    )
}
