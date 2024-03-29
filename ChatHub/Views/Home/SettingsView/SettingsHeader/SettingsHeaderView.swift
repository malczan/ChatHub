//
//  SettingsHeaderView.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

class SettingsHeaderView: UIView {
    
    private typealias Style = SettingsStyle
    
    var viewModel: SettingsViewModel!
    private let disposeBag = DisposeBag()
    
    private let avatarImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let logoutButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        installAvatarImage()
        installUsernameLabel()
        installLogoutButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inject(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        bind()
        bindButton()
    }
    
    private func bindButton() {
        logoutButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] in 
                self?.viewModel.buttonLogoutTapped()
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        viewModel
            .user
            .drive(onNext: {
                [weak self] in
                self?.updateContent(with: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateContent(with data: User?) {
        guard let data = data else { return }
        usernameLabel.text = data.username
        guard let urlString = data.profileImageUrl,
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
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
    
        usernameLabel.textColor = Style.whiteColor
        
        usernameLabel.font =  Style.usernameFont
        logoutButton.backgroundColor = Style.buttonColor
        logoutButton.setTitle("LOG OUT", for: .normal)
        logoutButton.setTitleColor(Style.backgroundColor, for: .normal)
        logoutButton.make3dButton()
    }
    
    private func installAvatarImage()  {
        self.addSubview(avatarImageView)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func installUsernameLabel() {
        self.addSubview(usernameLabel)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func installLogoutButton() {
        self.addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            logoutButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
}

