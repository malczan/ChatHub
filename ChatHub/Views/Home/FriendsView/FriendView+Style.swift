//
//  FriendView+Style.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import UIKit

enum FriendsViewStyle {
    
    static let navigationTitleAtr = [NSAttributedString.Key.foregroundColor:UIColor(named: "purple") as Any]
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let purpleColor = UIColor(named: "purple")
    static let whiteColor = UIColor.white
    
    static let textFieldAlpha = 0.3
    static let textFieldCornerRadius: CGFloat = 12
    static let textFieldPlaceholderAttr = NSAttributedString(
        string: "Search",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
    )
    
    static func searchBarIcon() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.tintColor = UIColor.white
        
        return imageView
    }
}
