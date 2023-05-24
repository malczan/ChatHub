//
//  PrivateMessageFooterView.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 23/05/2023.
//

import UIKit
import RxSwift

class PrivateMessageFooterView: UIView {

    private typealias Style = MessegasViewStyle
    
    var viewModel: PrivateMesssageViewModel!
    private let disposeBag = DisposeBag()

    private let messageTextField = UITextField()
    private let sendButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        installSendButton()
        installMessageTextField()
        bindButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inject(viewModel: PrivateMesssageViewModel) {
        self.viewModel = viewModel
        bindButton()
    }
    
    private func bindButton() {
        sendButton
            .rx
            .tap
            .subscribe(onNext: {
                [weak self] in
                self?.viewModel.goBackTapped()
            })
            .disposed(by: disposeBag)
    }
    
//
//    private func updateContent(with data: User?) {
//        guard let data = data else { return }
//        usernameLabel.text = data.username
//        guard let urlString = data.profileImageUrl,
//              let url = URL(string: urlString)
//        else {
//            return
//        }
//        avatarImageView.kf.setImage(
//            with: url,
//            placeholder: Style.avatarPlaceholder)
//    }
        
    private func setupStyle() {
        backgroundColor = Style.backgroundColor
        
        sendButton.tintColor = Style.purpleColor
        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.contentMode = .scaleAspectFill
        sendButton.contentHorizontalAlignment = .fill
        sendButton.contentVerticalAlignment = .fill
        messageTextField.layer.cornerRadius = 12
        messageTextField.backgroundColor = Style.lightPurpleColor?.withAlphaComponent(0.5)
        
    }
    
    private func installSendButton() {
        self.addSubview(sendButton)

        sendButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sendButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 36),
            sendButton.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func installMessageTextField() {
        self.addSubview(messageTextField)
        
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageTextField.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
  
}
