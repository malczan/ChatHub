//
//  PopUpView.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class PopUpView: UIView {
    
    private var viewModel: PopUpViewModel!
    private let disposeBag = DisposeBag()
    
    private let messageLabel = UILabel()
    private let okButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inject(viewModel: PopUpViewModel) {
        self.viewModel = viewModel
        messageLabel.text = viewModel.labelText
        bind()
    }
    
    private func bind() {
        okButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.buttonTapped()
                
            })
            .disposed(by: disposeBag)
    }
    
    private func setupView() {
        self.addSubview(messageLabel)
        self.addSubview(okButton)
        backgroundColor = UIColor(named: "backgroundColor")
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        messageLabel.textColor = .white
        
        okButton.backgroundColor = UIColor(named: "purple")
        okButton.setTitle("OK", for: .normal)
        okButton.setTitleColor(UIColor(named: "backgroundColor"), for: .normal)
        okButton.make3dButton()
        
        messageLabel.contentMode = .scaleToFill
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            okButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor,  constant: 50),
            okButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -50),
            okButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5),
            okButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
