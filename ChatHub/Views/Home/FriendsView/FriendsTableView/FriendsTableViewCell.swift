//
//  FriendsTableViewCell.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

//    private typealias Style = MessegesViewStyle
//    typealias MessegePreviewModel = MessegesViewModel.MessegePreviewModel
    
    private let friendAvatarImage = UIImageView()
    private let friendNameLabel = UILabel()
    private let firstButton = UIButton()
    private let secondButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        installAvatarImage()
        installFriendNameLabel()
        installFirstButton()
        installSecondButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var friendModel: FriendModel? {
        didSet {
            updateContent(with: friendModel)
        }
    }
    
    var viewModel: FriendsViewModel? {
        didSet {
           bind()
        }
    }
    
    private func bind() {
        
    }
    
    private func setupStyle() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        friendAvatarImage.image = UIImage(named: "avatar-placeholder")
        friendAvatarImage.layer.cornerRadius = 21
        friendAvatarImage.clipsToBounds = true
        friendAvatarImage.contentMode = .scaleAspectFill
        friendNameLabel.textColor = UIColor(named: "purple")
        friendNameLabel.textColor = .white
    }

    private func installAvatarImage() {
        friendAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(friendAvatarImage)
        
        NSLayoutConstraint.activate([
            friendAvatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendAvatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendAvatarImage.heightAnchor.constraint(equalToConstant: 42),
            friendAvatarImage.widthAnchor.constraint(equalToConstant: 42)
            
        ])
    }
    
    private func installFriendNameLabel() {
        friendNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(friendNameLabel)

        NSLayoutConstraint.activate([
            friendNameLabel.centerYAnchor.constraint(equalTo: friendAvatarImage.centerYAnchor),
            friendNameLabel.leadingAnchor.constraint(equalTo: friendAvatarImage.trailingAnchor, constant: 10)
        ])
    }
    
    private func installFirstButton() {
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstButton)
        
        firstButton.setImage(UIImage(systemName: "message.fill"), for: .normal)
        
        NSLayoutConstraint.activate([
            firstButton.heightAnchor.constraint(equalToConstant: 20),
            firstButton.widthAnchor.constraint(equalToConstant: 20),
            firstButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            firstButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func installSecondButton() {
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(secondButton)
        
        secondButton.setImage(UIImage(systemName: "message.fill"), for: .normal)
        
        NSLayoutConstraint.activate([
            secondButton.heightAnchor.constraint(equalToConstant: 20),
            secondButton.widthAnchor.constraint(equalToConstant: 20),
            secondButton.trailingAnchor.constraint(equalTo: firstButton.leadingAnchor, constant: -10),
            secondButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func updateContent(with friend: FriendModel?) {
        guard let friendModel = friendModel  else {
            return
        }
        
        friendNameLabel.text = friendModel.nickname
        
        guard let imageUrlString = friendModel.photoUrl,
              let imageUrl = URL(string: imageUrlString)
        else {
            return
        }
        
        friendAvatarImage.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "avatar-placeholder"))
    }
}
