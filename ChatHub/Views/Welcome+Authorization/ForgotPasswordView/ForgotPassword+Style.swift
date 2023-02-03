//
//  ForgotPassword+Style.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/02/2023.
//

import UIKit

enum ForgotPasswordStyle {
    
    private typealias texts = ForgotPasswordConstants
    
    // AttString
    static let goBackAttributeString = attributeStringGoBack()
    
    static let goBackRange = (texts.goBack as NSString).range(of: texts.goBackClickable)
    
    // Colors
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let buttonColorDisabled = UIColor(named: "lightPurple")
    static let buttonColorEnabled = UIColor(named: "purple")
    static let fontColor = UIColor.white
    
    // Icons
    static let loginIcon = "person"
    static let passwordIcon = "lock"
    
    // Images
    static let logoImage = UIImage(named: "LOGO")
    
    private static func attributeStringGoBack() -> NSMutableAttributedString {
        let text = texts.goBack
        let attriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: texts.goBackClickable)
        attriString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)
        attriString.addAttribute(NSAttributedString.Key.foregroundColor, value: buttonColorEnabled!, range: range)
        return attriString
    }
}
