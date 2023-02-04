//
//  SettingsTableViewCell.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    private typealias Style = SettingsStyle
    
    private let settingLabel = UILabel()
    private let settingIconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        installLabel()
        installIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: SettingModel? {
        didSet {
            guard let model = model else {
                return
            }
            settingLabel.text = model.title
            settingIconView.image = UIImage(systemName: model.icon)
        }
    }
    
    private func setupStyle() {
        self.backgroundColor = .clear
        settingLabel.font = Style.settingFont
        settingLabel.textColor = Style.buttonColor
        settingIconView.tintColor = Style.buttonColor
        settingIconView.contentMode = .scaleAspectFill
    }
    
    private func installLabel() {
        self.addSubview(settingLabel)
        
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            settingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func installIcon() {
        self.addSubview(settingIconView)
        
        settingIconView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            settingIconView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            settingIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            settingIconView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
}
