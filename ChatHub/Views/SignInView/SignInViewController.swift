//
//  SignInViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 28/01/2023.
//

import UIKit
import RxCocoa
import RxSwift


class SignInViewController: UIViewController {
    
    private typealias Style = SignInStyle
    private typealias Constants = SignInConstants
    
    var viewModel: SignInViewModel!
    private let disposeBag = DisposeBag()
    private let tapGesture = UITapGestureRecognizer()
    
    private let logoImageView = UIImageView()
    
    private let usernameTextField = CustomTextField(icon: Style.loginIcon,
                                                 placeholderText: Constants.login)
    private let passwordTextField = CustomTextField(icon: Style.passwordIcon,
                                                    placeholderText: Constants.password,
                                                    password: true)
    private let loginButton = UIButton()
    private let forgotPasswordLabel = UILabel()
    private let createAccountLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupStyle()
        installLogoImageView()
        installLoginTextField()
        installPasswordTextField()
        installLoginButton()
        installForgotPasswordLabel()
        installCreateAccountLabel()
    }
    
    private func bind() {
        usernameTextField
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.usernameRelay)
            .disposed(by: disposeBag)
        
        passwordTextField
            .rx
            .text
            .map { $0 ?? "" }
            .bind(to: viewModel.passwordRelay)
            .disposed(by: disposeBag)
        
        viewModel
            .isValid()
            .map { $0 ? Style.buttonColorEnabled : Style.buttonColorDisabled }
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
    
        viewModel
            .isValid()
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func setupStyle() {
        view.backgroundColor = Style.backgroundColor
        
        logoImageView.image = Style.logoImage
        logoImageView.contentMode = .scaleAspectFit
    
        loginButton.setTitle(Constants.login.uppercased(),
                             for: .normal)
        loginButton.setTitleColor(Style.backgroundColor,
                                  for: .normal)
        
        forgotPasswordLabel.text = Constants.forgotPassword
        forgotPasswordLabel.textColor = Style.fontColor
        forgotPasswordLabel.attributedText = Style.forgotPasswordAttributeString
        
        createAccountLabel.text = Constants.createAccount
        createAccountLabel.textColor = Style.fontColor
        createAccountLabel.attributedText = Style.createAccountAttributeString
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
    
    private func installLoginTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            usernameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installPasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: 80),
            passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            loginButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    private func installForgotPasswordLabel() {
        view.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(forgotPasswordTapped)))
        
        
        forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            forgotPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
        
    private func installCreateAccountLabel() {
        view.addSubview(createAccountLabel)
        createAccountLabel.isUserInteractionEnabled = true
        createAccountLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(createAccountTapped)))
        
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createAccountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
    
    @objc private func createAccountTapped(gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: createAccountLabel, inRange: Style.createAccountRange) {
            viewModel.createAccountTapped()
        }
    }
    
    @objc private func forgotPasswordTapped(gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: forgotPasswordLabel, inRange: Style.forgotPasswordRange) {
            viewModel.forgotPasswordTapped()
        }
    }

}
