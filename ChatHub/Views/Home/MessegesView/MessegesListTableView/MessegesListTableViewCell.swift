//
//  MessegesListTableViewCell.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import UIKit

class MessegesListTableViewCell: UITableViewCell {
    
    private typealias Style = MessagesViewStyle
     typealias MessegePreviewModel = MessagesViewModel.MessegePreviewModel
    
    private let messegeAvatarImage = UIImageView()
    private let messegeNameLabel = UILabel()
    private let messegePreviewLabel = UILabel()
    
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
        messegeNameLabel.textColor = Style.purpleColor
        messegePreviewLabel.textColor = .white

    }
    
    var messegePreviewModel: MessegePreviewModel? {
        didSet {
            updateContext(with: messegePreviewModel)
        }
    }
    
    func updateContext(with message: MessegePreviewModel?) {
        guard let message = message else {
            return
        }
        
        messegeNameLabel.text = message.senderName
        messegePreviewLabel.text = message.messegePreview
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
