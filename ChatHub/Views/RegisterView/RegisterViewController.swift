//
//  RegisterViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController {
    
    private typealias Style = RegisterStyle
    private typealias Constants = RegisterConstants
    
    private let viewModel = RegisterViewModel()
    private let disposeBag = DisposeBag()
    
    private let logoImageView = UIImageView()
    private let usernameTextField = CustomTextField(icon: Style.loginIcon, placeholderText: Constants.username)
    private let emailTextField = CustomTextField(icon: Style.emailIcon, placeholderText: Constants.email)
    private let passwordTextField = CustomTextField(icon: Style.passwordIcon,
                                                    placeholderText: Constants.password,
                                                    password: true)
    private let confirmPasswordTextField = CustomTextField(icon: Style.passwordIcon,
                                                           placeholderText: Constants.confirmPassword,
                                                           password: true)
    private let loginButton = UIButton()
    private let forgotPasswordLabel = UILabel()
    private let createAccountLabel = UILabel()
    private let alreadyHaveAccountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupStyle()
        setupLogoImageView()
        installLoginTextField()
        installEmailTextField()
        installPasswordTextField()
        installConfirmPasswordTextField()
        installLoginButton()
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

        loginButton.setTitle(Constants.register,
                             for: .normal)
        loginButton.setTitleColor(Style.backgroundColor,
                                  for: .normal)
        
        alreadyHaveAccountLabel.text = Constants.alreadyHaveAccount
        alreadyHaveAccountLabel.textColor = Style.fontColor
        alreadyHaveAccountLabel.attributedText = Style.createAccountAttributeString
        
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
    
    private func installLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            loginButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func installAlreadyHaveAccountLabel() {
        view.addSubview(alreadyHaveAccountLabel)
        
        alreadyHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alreadyHaveAccountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            alreadyHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
