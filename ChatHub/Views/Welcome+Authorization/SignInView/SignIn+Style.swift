//
//  SignIn+Style.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 28/01/2023.
//

import UIKit

enum SignInStyle {
    
    private typealias texts = SignInConstants
    
    // AttString
    static let createAccountAttributeString = attributeStringCreateAccount()
    static let forgotPasswordAttributeString = attributeStringForgotPassword()
    
    static let createAccountRange = (texts.createAccount as NSString).range(of: texts.createAccountClickable)
    static let forgotPasswordRange = (texts.forgotPassword as NSString).range(of: texts.forgotPasswordClickable)
    
    // Colors
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let buttonColorDisabled = UIColor(named: "lightPurple")
    static let buttonColorEnabled = UIColor(named: "purple")
    static let fontColor = UIColor.white
    
    // Icons
    static let emailIcon = "envelope"
    static let passwordIcon = "lock"
    
    // Images
    static let logoImage = UIImage(named: "LOGO")
    
    private static func attributeStringCreateAccount() -> NSMutableAttributedString {
        let text = texts.createAccount
        let attriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: texts.createAccountClickable)
        attriString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)
        attriString.addAttribute(NSAttributedString.Key.foregroundColor, value: buttonColorEnabled!, range: range)
        return attriString
    }
    
    private static func attributeStringForgotPassword() -> NSMutableAttributedString {
        let text = texts.forgotPassword
        let attriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: texts.forgotPasswordClickable)
        attriString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)
        attriString.addAttribute(NSAttributedString.Key.foregroundColor, value: buttonColorEnabled!, range: range)
        return attriString
    }
}
                                               
                                               
