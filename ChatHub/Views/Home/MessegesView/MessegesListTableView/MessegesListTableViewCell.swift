//
//  MessegesListTableViewCell.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import UIKit
import Kingfisher
import RxSwift

class MessegesListTableViewCell: UITableViewCell {
    
    private typealias Style = MessagesViewStyle
     typealias MessegePreviewModel = MessagesViewModel.MessegePreview
    
    var viewModel: MessagesViewModel!
    
    private let messegeAvatarImage = UIImageView()
    private let messegeNameLabel = UILabel()
    private let messegePreviewLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        installAvatarImage()
        installMessegeNameLabel()
        installMessegePreviewLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupStyle() {
        self.selectionStyle = .none
        self.backgroundColor = MessagesViewStyle.backgroundColor
        messegeAvatarImage.image = UIImage(named: "avatar-placeholder")
        messegeAvatarImage.layer.cornerRadius = 18
        messegeAvatarImage.clipsToBounds = true
        messegeAvatarImage.contentMode = .scaleAspectFill
        messegeNameLabel.textColor = Style.purpleColor
        messegePreviewLabel.textColor = .white

    }

    var messegePreviewModel: MessegePreviewModel? {
        didSet {
            updateContext(with: messegePreviewModel)
        }
    }
    
    func inject(viewModel: MessagesViewModel) {
        self.viewModel = viewModel
    }
    
    func updateContext(with message: MessegePreviewModel?) {
        guard let message = message else {
            return
        }
        viewModel
            .getUserInfo(with: message.userId!)
            .subscribe(onNext: {
                [weak self] in
                self?.updateMessagePreview(with: $0, message: message)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateMessagePreview(with user: User, message: MessegePreviewModel) {
        messegeNameLabel.font = message
            .sendByCurrentUser ?
                UIFont.systemFont(ofSize: 18) :
                UIFont.boldSystemFont(ofSize: 18)
        messegePreviewLabel.font = message
            .sendByCurrentUser ?
                UIFont.systemFont(ofSize: 18) :
                UIFont.boldSystemFont(ofSize: 18)
        messegePreviewLabel.text = message
            .sendByCurrentUser ?
                "You: \(message.message ?? "")" :
                message.message
        messegeNameLabel.text = user.username
        guard let urlString = user.profileImageUrl,
              let url = URL(string: urlString)
        else {
            return
        }
        messegeAvatarImage.kf.setImage(
            with: url,
            placeholder: Style.avatarPlaceholder)
    }
    
    private func installAvatarImage() {
        messegeAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messegeAvatarImage)
        
        NSLayoutConstraint.activate([
            messegeAvatarImage.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            messegeAvatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messegeAvatarImage.heightAnchor.constraint(equalToConstant: 52),
            messegeAvatarImage.widthAnchor.constraint(equalToConstant: 52)
            
        ])
    }
    
    private func installMessegeNameLabel() {
        messegeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messegeNameLabel)

        NSLayoutConstraint.activate([
            messegeNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
            messegeNameLabel.leadingAnchor.constraint(equalTo: messegeAvatarImage.trailingAnchor, constant: 10)
            
        ])
    }
    
    private func installMessegePreviewLabel() {
        messegePreviewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messegePreviewLabel)

        NSLayoutConstraint.activate([
            messegePreviewLabel.centerYAnchor.constraint(equalTo: messegeAvatarImage.centerYAnchor),
            messegePreviewLabel.leadingAnchor.constraint(equalTo: messegeAvatarImage.trailingAnchor, constant: 10),
            messegePreviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200)
            
        ])
    }
}
