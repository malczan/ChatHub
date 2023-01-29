//
//  Register+Style.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit

enum RegisterStyle {
    
    private typealias texts = RegisterConstants
  
    // AttString
    static let createAccountAttributeString = attributeStringAlreadyHaveAccount()
    
    // Colors
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let buttonColorDisabled = UIColor(named: "purpleLight")
    static let buttonColorEnabled = UIColor(named: "purple")
    static let fontColor = UIColor.white
    
    // Icons
    static let emailIcon = "envelope"
    static let loginIcon = "person"
    static let passwordIcon = "lock"
    
    // Images
    static let logoImage = UIImage(named: "LOGO")
    
    private static func attributeStringAlreadyHaveAccount() -> NSMutableAttributedString {
        let text = texts.alreadyHaveAccount
        let attriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: texts.alreadyHaveAccountClickable)
        attriString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)
        attriString.addAttribute(NSAttributedString.Key.foregroundColor, value: buttonColorEnabled!, range: range)
        return attriString
    }
}
