//
//  FriendsTableViewCell.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import UIKit
import RxCocoa
import RxSwift

class FriendsTableViewCell: UITableViewCell {
    
    private let friendAvatarImage = UIImageView()
    private let friendNameLabel = UILabel()
    private let firstButton = UIButton()
    private let secondButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
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
        firstButton.rx
            .tap
            .subscribe(onNext: {
                [weak self] in
                self?.viewModel?.firstButtonTapped(
                    self?.friendModel?.friendStatus)
            })
            .disposed(by: disposeBag)
        
        secondButton.rx
            .tap
            .subscribe(onNext: {
                [weak self] in
                self?.viewModel?.secondButtonTapped(
                    self?.friendModel?.friendStatus)
            })
            .disposed(by: disposeBag)
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
        firstButton.tintColor = UIColor(named: "purple")
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
        contentView.addSubview(firstButton)
        
        NSLayoutConstraint.activate([
            firstButton.heightAnchor.constraint(equalToConstant: 32),
            firstButton.widthAnchor.constraint(equalToConstant: 32),
            firstButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            firstButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func installSecondButton() {
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(secondButton)
        
        NSLayoutConstraint.activate([
            secondButton.heightAnchor.constraint(equalToConstant: 32),
            secondButton.widthAnchor.constraint(equalToConstant: 32),
            secondButton.trailingAnchor.constraint(equalTo: firstButton.leadingAnchor, constant: -10),
            secondButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func updateContent(with friend: FriendModel?) {
        guard let friendModel = friendModel  else {
            return
        }
        
        friendNameLabel.text = friendModel.nickname

        switch friendModel.friendStatus {
        case .stranger:
            firstButton.setImage(UIImage(systemName: "message.fill"), for: .normal)
            secondButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
            secondButton.tintColor = .green
        case .requestedFriend:
            firstButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            firstButton.tintColor = .green
            secondButton.setImage(UIImage(systemName: "trash.circle"), for: .normal)
            secondButton.tintColor = .systemRed
        case .pendingFriend:
            firstButton.setImage(UIImage(systemName: "message.fill"), for: .normal)
            secondButton.setImage(UIImage(systemName: "person.badge.clock"), for: .normal)
            secondButton.tintColor = .systemYellow
        case .friend:
            firstButton.setImage(UIImage(systemName: "message.fill"), for: .normal)
            secondButton.setImage(UIImage(systemName: "person.badge.minus"), for: .normal)
            secondButton.tintColor = .systemRed
        }
        
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
