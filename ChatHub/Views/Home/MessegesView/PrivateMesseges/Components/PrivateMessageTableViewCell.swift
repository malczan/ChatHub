//
//  PrivateMessageTableViewCell.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 26/05/2023.
//

import UIKit

class PrivateMessageTableViewCell: UITableViewCell {
    
    typealias Style = MessagesViewStyle
    typealias MessageModel = PrivateMesssageViewModel.MessageModel

    let messageLabel = UILabel()
    let messageBackroundView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        installMessageBubble()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: MessageModel? {
        didSet {
            updateContext(with: model)
        }
    }
    
    private func updateContext(with model: MessageModel?) {
        guard let model = model else {
            return
        }

        messageLabel.text = model.message
        
        switch model.fromCurrentUser {
        case true:
            setupSentMessage()
        case false:
            setupReceivedMessage()
        }
    }
    private func setupStyle() {
        backgroundColor = Style.backgroundColor
        messageBackroundView.backgroundColor = UIColor(named: "purple")
        
        messageLabel.numberOfLines = 0
        messageBackroundView.layer.cornerRadius = 8
        selectionStyle = .none
    }
    
    private func installMessageBubble() {
        addSubview(messageBackroundView)
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageBackroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupReceivedMessage() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(equalToConstant: 250),
            
            messageBackroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            messageBackroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            messageBackroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            messageBackroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ])
    }
    
    private func setupSentMessage() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageBackroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            messageBackroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            messageBackroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            messageBackroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ])
    }
    
}
