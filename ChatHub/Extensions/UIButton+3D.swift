//
//  UIButton+3D.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/02/2023.
//

import Foundation
import UIKit

extension UIButton {

    func make3dButton()  {
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSize(width: -2, height: 3)
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
