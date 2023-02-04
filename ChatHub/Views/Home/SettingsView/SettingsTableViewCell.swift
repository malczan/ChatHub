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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupStyle() {
        self.backgroundColor = .clear
        self.addSubview(settingLabel)
        self.addSubview(settingIconView)
        
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingIconView.translatesAutoresizingMaskIntoConstraints = false
        
        settingLabel.font = Style.settingFont
        settingLabel.text = "Upload image photo"
        settingLabel.textColor = UIColor(named: "purple")
        
        settingIconView.image = UIImage(systemName: "photo")
        settingIconView.tintColor = UIColor(named: "purple")
        settingIconView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            settingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            settingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            settingIconView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            settingIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            settingIconView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    

}
