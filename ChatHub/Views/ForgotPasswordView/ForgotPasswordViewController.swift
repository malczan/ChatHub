//
//  ForgotPasswordViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 30/01/2023.
//

import UIKit
import RxCocoa
import RxSwift

class ForgotPasswordViewController: UIViewController {
    
    private typealias Style = ForgotPasswordStyle
    private typealias Constants = ForgotPasswordConstants
    
    var viewModel: ForgotPasswordViewModel!
    private let disposeBag = DisposeBag()
    
    private let logoImageView = UIImageView()
    
    private let usernameTextField = CustomTextField(icon: Style.loginIcon,
                                                    placeholderText: Constants.username)
    private let emailTextField = CustomTextField(icon: Style.passwordIcon,
                                                 placeholderText: Constants.email)
    private let confirmButton = UIButton()
    private let goBackLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupStyle()
        installLogoImageView()
        installUsernameTextField()
        installEmailTextField()
        installConfirmButton()
        installGoBackLabel()
    }
    
    private func bind() {
        usernameTextField
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.usernameRelay)
            .disposed(by: disposeBag)
        
        emailTextField
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.emailRelay)
            .disposed(by: disposeBag)
        
        confirmButton
            .rx
            .tap
            .bind(to: viewModel.confirmSubject)
            .disposed(by: disposeBag)
        
        viewModel
            .isValid()
            .map { $0 ? Style.buttonColorEnabled : Style.buttonColorDisabled }
            .bind(to: confirmButton.rx.backgroundColor)
            .disposed(by: disposeBag)
    
        viewModel
            .isValid()
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func setupStyle() {
        view.backgroundColor = Style.backgroundColor
        
        logoImageView.image = Style.logoImage
        logoImageView.contentMode = .scaleAspectFit
        
        confirmButton.setTitle(Constants.confirm,
                             for: .normal)
        confirmButton.setTitleColor(Style.backgroundColor,
                                  for: .normal)
        confirmButton.make3dButton()
        
        goBackLabel.textColor = Style.fontColor
        goBackLabel.attributedText = Style.goBackAttributeString
    }
    
    private func installLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            logoImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func installUsernameTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            usernameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installEmailTextField() {
        view.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: 80),
            emailTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installConfirmButton() {
        view.addSubview(confirmButton)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            confirmButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            confirmButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func installGoBackLabel() {
        view.addSubview(goBackLabel)
        
        goBackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        goBackLabel.isUserInteractionEnabled = true
        goBackLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBackTapped)))
        
        NSLayoutConstraint.activate([
            goBackLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            goBackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc private func goBackTapped(gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: goBackLabel, inRange: Style.goBackRange) {
            viewModel.goBackTapped()
        }
    }
    
    
    
}
