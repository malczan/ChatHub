//
//  CustomTextField.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 28/01/2023.
//

import UIKit

class CustomTextField: UITextField {
    
    private let icon: String
    private let iconImageView = UIImageView()
    private let placeholderText: String
    private let themeColor: UIColor
    
    
    init(frame: CGRect = CGRect(),
         icon: String,
         placeholderText: String,
         themeColor: UIColor? = .white) {
        self.placeholderText = placeholderText
        self.icon = icon
        self.themeColor = themeColor!
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0);
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0);
    }

    private func setup() {
        self.addSubview(iconImageView)
        self.borderStyle = .none
        self.textColor = themeColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: themeColor])
    
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = themeColor
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
}

