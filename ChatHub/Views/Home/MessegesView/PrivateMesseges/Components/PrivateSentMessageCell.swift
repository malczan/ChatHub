//
//  PrivateMessageTableViewCell.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 26/05/2023.
//

import UIKit

class PrivateSentMessageCell: UITableViewCell {
    
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
        messageBackroundView.backgroundColor = UIColor(named: "purple")
    }
    
    private func setupStyle() {
        backgroundColor = Style.backgroundColor
        
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        messageBackroundView.layer.cornerRadius = 8
        selectionStyle = .none
    }
    
    private func installMessageBubble() {
        addSubview(messageBackroundView)
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageBackroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                        
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageBackroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -14),
            messageBackroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -14),
            messageBackroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 14),
            messageBackroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 14)
        ])
    }
}

