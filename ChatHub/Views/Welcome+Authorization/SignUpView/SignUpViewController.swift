//
//  SignUpViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {
    
    private typealias Style = SignUpStyle
    private typealias Constants = SignUpConstants
    
    var viewModel: SignUpViewModel!
    private let disposeBag = DisposeBag()
    
    private let logoImageView = UIImageView()
    private let usernameTextField = CustomTextField(icon: Style.loginIcon,
                                                    placeholderText: Constants.username)
    private let emailTextField = CustomTextField(icon: Style.emailIcon,
                                                 placeholderText: Constants.email)
    private let passwordTextField = CustomTextField(icon: Style.passwordIcon,
                                                    placeholderText: Constants.password,
                                                    password: true)
    private let confirmPasswordTextField = CustomTextField(icon: Style.passwordIcon,
                                                           placeholderText: Constants.confirmPassword,
                                                           password: true)
    private let registerButton = UIButton()
    private let messageLabel = UILabel()
    private let alreadyHaveAccountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupStyle()
        setupLogoImageView()
        installUsernameTextField()
        installEmailTextField()
        installPasswordTextField()
        installConfirmPasswordTextField()
        installRegisterButton()
        installMessageLabel()
        installAlreadyHaveAccountLabel()
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
        
        passwordTextField
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.passwordRelay)
            .disposed(by: disposeBag)
        
        confirmPasswordTextField
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.confirmPasswordRelay)
            .disposed(by: disposeBag)
        
        registerButton
            .rx
            .tap
            .subscribe(onNext: {
                [weak self] in
                self?.viewModel.signUpTapped()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .isValid()
            .map { $0 ? Style.buttonColorEnabled : Style.buttonColorDisabled }
            .bind(to: registerButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel
            .isValid()
            .bind(to: registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel
            .arePasswordTheSame()
            .bind(to: messageLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func setupStyle() {
        view.backgroundColor = Style.backgroundColor
        
        logoImageView.image = Style.logoImage
        logoImageView.contentMode = .scaleAspectFit

        registerButton.setTitle(Constants.register,
                             for: .normal)
        registerButton.setTitleColor(Style.backgroundColor,
                                  for: .normal)
        registerButton.make3dButton()
        
        messageLabel.text = Constants.passwordsAreNotTheSame
        messageLabel.textColor = Style.errorColor
        
        alreadyHaveAccountLabel.textColor = Style.fontColor
        alreadyHaveAccountLabel.attributedText = Style.alreadyHaveAccountAttributeString
    }
    
    private func setupLogoImageView() {
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
        
        private func installPasswordTextField() {
            view.addSubview(passwordTextField)
            
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 80),
                passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                passwordTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        
        private func installConfirmPasswordTextField() {
            view.addSubview(confirmPasswordTextField)
            
            confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 80),
                confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        
        private func installRegisterButton() {
            view.addSubview(registerButton)
            
            registerButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
                registerButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
                registerButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
                registerButton.heightAnchor.constraint(equalToConstant: 40),
            ])
        }
    
    private func installMessageLabel() {
        view.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func installAlreadyHaveAccountLabel() {
        view.addSubview(alreadyHaveAccountLabel)
        alreadyHaveAccountLabel.isUserInteractionEnabled = true
        alreadyHaveAccountLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(alreadyHaveAccountTapped)))
        
        alreadyHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alreadyHaveAccountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            alreadyHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func alreadyHaveAccountTapped(gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: alreadyHaveAccountLabel, inRange: Style.alreadyHaveAccounttRange) {
            viewModel.alreadyHaveAccountTapped()
        }
    }
}
