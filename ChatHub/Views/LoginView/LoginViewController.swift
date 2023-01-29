//
//  LoginViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 28/01/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private typealias Style = LoginStyle
    private typealias Constants = LoginConstants
    
    private let logoImageView = UIImageView()
    
    private let loginTextField = CustomTextField(icon: Style.loginIcon,
                                                 placeholderText: Constants.login)
    private let passwordTextField = CustomTextField(icon: Style.passwordIcon,
                                                    placeholderText: Constants.password,
                                                    password: true)
    private let loginButton = UIButton()
    private let forgotPasswordLabel = UILabel()
    private let createAccountLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        installLogoImageView()
        installLoginTextField()
        installPasswordTextField()
        installLoginButton()
        installForgotPasswordLabel()
        installCreateAccountLabel()
    }
    
    private func setupStyle() {
        view.backgroundColor = Style.backgroundColor
        
        logoImageView.image = Style.logoImage
        logoImageView.contentMode = .scaleAspectFit
    
        loginButton.backgroundColor = Style.buttonColorEnabled
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
        view.addSubview(loginTextField)
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            loginTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installPasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.topAnchor, constant: 80),
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
        
        forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            forgotPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
        
    private func installCreateAccountLabel() {
        view.addSubview(createAccountLabel)
        
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createAccountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
}

