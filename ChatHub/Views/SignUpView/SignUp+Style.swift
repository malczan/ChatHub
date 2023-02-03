//
//  SignUp+Style.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit

enum SignUpStyle {
    
    private typealias texts = SignUpConstants
  
    // AttString
    static let alreadyHaveAccountAttributeString = attributeStringAlreadyHaveAccount()
    
    static let alreadyHaveAccounttRange = (texts.alreadyHaveAccount as NSString).range(of: texts.alreadyHaveAccountClickable)

    
    // Colors
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let buttonColorDisabled = UIColor(named: "lightPurple")
    static let buttonColorEnabled = UIColor(named: "purple")
    static let errorColor = UIColor.systemRed
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
