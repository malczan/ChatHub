//
//  PrivateMessageHeaderView.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 23/05/2023.
//

import UIKit
import Kingfisher
import RxSwift

class PrivateMessageHeaderView: UIView {

    private typealias Style = MessagesViewStyle
    
    var viewModel: PrivateMesssageViewModel!
    private let disposeBag = DisposeBag()
    
    private let avatarImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let goBackButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        installUsernameLabel()
        installAvatarImage()
        installGoBackButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inject(viewModel: PrivateMesssageViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    private func bind() {
        goBackButton
            .rx
            .tap
            .subscribe(onNext: {
                [weak self] in
                self?.viewModel.goBackTapped()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .userDriver
            .drive(onNext: {
                [weak self] user in
                self?.updateUserData(with: user)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUserData(with user: User) {
        self.usernameLabel.text =  user.username
        guard let urlString = user.profileImageUrl,
              let url = URL(string: urlString)
        else {
            return
        }
        avatarImageView.kf.setImage(
            with: url,
            placeholder: Style.avatarPlaceholder)
    
    }
        
    private func setupStyle() {
        backgroundColor = Style.backgroundColor
        avatarImageView.image = Style.avatarPlaceholder
        avatarImageView.layer.cornerRadius = 21
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        

        usernameLabel.textColor = Style.purpleColor
        usernameLabel.text = "Jakub Malczyk"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        goBackButton.tintColor = Style.purpleColor
        goBackButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        goBackButton.clipsToBounds = true
        goBackButton.contentMode = .scaleAspectFit
        goBackButton.contentHorizontalAlignment = .fill
        goBackButton.contentVerticalAlignment = .fill
    }
    
    private func installUsernameLabel() {
        self.addSubview(usernameLabel)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func installGoBackButton() {
        self.addSubview(goBackButton)
        
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goBackButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            goBackButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            goBackButton.heightAnchor.constraint(equalToConstant: 32),
            goBackButton.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    private func installAvatarImage() {
        self.addSubview(avatarImageView)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 42),
            avatarImageView.widthAnchor.constraint(equalToConstant: 42),
        ])
    }
    
}
