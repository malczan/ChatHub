//
//  RegisterViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private typealias Style = RegisterStyle
    private typealias Constants = RegisterConstants
    
    private let logoImageView = UIImageView()
    private let loginTextField = CustomTextField(icon: Style.loginIcon, placeholderText: Constants.username)
    private let loginUnderline = UIView()
    private let emailTextField = CustomTextField(icon: Style.emailIcon, placeholderText: Constants.email)
    private let emailUnderline = UIView()
    private let passwordTextField = CustomTextField(icon: Style.passwordIcon,
                                                    placeholderText: Constants.password,
                                                    password: true)
    private let passwordUnderline = UIView()
    private let confirmPasswordTextField = CustomTextField(icon: Style.passwordIcon,
                                                           placeholderText: Constants.confirmPassword,
                                                           password: true)
    private let confirmPasswordUnderline = UIView()
    private let loginButton = UIButton()
    private let forgotPasswordLabel = UILabel()
    private let createAccountLabel = UILabel()
    private let alreadyHaveAccountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupLogoImageView()
        installLoginTextField()
        installLoginUnderline()
        installEmailTextField()
        installEmailUnderline()
        installPasswordTextField()
        installPasswordUnderline()
        installConfirmPasswordTextField()
        installConfirmPasswordUnderline()
        installLoginButton()
        installAlreadyHaveAccountLabel()


        // Do any additional setup after loading the view.
    }
    
    private func setupStyle() {
        view.backgroundColor = Style.backgroundColor
        
        logoImageView.image = Style.logoImage
        logoImageView.contentMode = .scaleAspectFit
    
        loginUnderline.backgroundColor = Style.fontColor
        
        emailUnderline.backgroundColor = Style.fontColor
        
        passwordUnderline.backgroundColor = Style.fontColor
        
        confirmPasswordUnderline.backgroundColor = Style.fontColor
        
        loginButton.backgroundColor = Style.buttonColorEnabled
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
        view.addSubview(loginTextField)
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            loginTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installLoginUnderline() {
        view.addSubview(loginUnderline)
        
        loginUnderline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginUnderline.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            loginUnderline.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            loginUnderline.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            loginUnderline.heightAnchor.constraint(equalToConstant: 1),
            
        ])
    }
    
    private func installEmailTextField() {
        view.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: loginTextField.topAnchor, constant: 80),
            emailTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installEmailUnderline() {
        view.addSubview(emailUnderline)
        
        emailUnderline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailUnderline.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            emailUnderline.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            emailUnderline.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            emailUnderline.heightAnchor.constraint(equalToConstant: 1),
            
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
    
    private func installPasswordUnderline() {
        view.addSubview(passwordUnderline)
        
        passwordUnderline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordUnderline.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            passwordUnderline.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            passwordUnderline.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            passwordUnderline.heightAnchor.constraint(equalToConstant: 1),
            
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
    
    private func installConfirmPasswordUnderline() {
        view.addSubview(confirmPasswordUnderline)
        
        confirmPasswordUnderline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            confirmPasswordUnderline.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor),
            confirmPasswordUnderline.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            confirmPasswordUnderline.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            confirmPasswordUnderline.heightAnchor.constraint(equalToConstant: 1),
            
        ])
    }
    
    private func installLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: confirmPasswordUnderline.bottomAnchor, constant: 30),
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
