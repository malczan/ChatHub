//
//  WelcomeViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 28/01/2023.
//

import UIKit
import RxCocoa
import RxSwift

class WelcomeViewController: UIViewController {
    
    private typealias Style = WelcomeStyle
    private typealias Constants = WelcomeConstants
    
    var viewModel: WelcomeViewModel!
    private let diposeBag = DisposeBag()
    
    private let logoImageView = UIImageView()
    private let chatImageView = UIImageView()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupStyle()
        installLogoImageView()
        installchatImageView()
        installSignInButton()
        installSignUpButton()
    }
    
    private func bind() {
        signInButton
            .rx
            .tap
            .bind(to: viewModel.signInSubject)
            .disposed(by: diposeBag)
        
        signUpButton
            .rx
            .tap
            .bind(to: viewModel.signUpSubject)
            .disposed(by: diposeBag)
    }
    
    private func setupStyle() {
        view.backgroundColor = Style.backgroundColor
        
        logoImageView.image = Style.logoImage
        logoImageView.contentMode = .scaleAspectFit
        
        chatImageView.image = Style.chatImage
        chatImageView.contentMode = .scaleAspectFit
        
        signInButton.backgroundColor = Style.signInButtonColor
        signInButton.setTitle(Constants.signIn.uppercased(), for: .normal)
        signInButton.setTitleColor(Style.whiteColor, for: .normal)
        
        signUpButton.backgroundColor = Style.signUpButtonColor
        signUpButton.setTitle(Constants.signUp.uppercased(), for: .normal)
        signUpButton.setTitleColor(Style.whiteColor, for: .normal)
        
    }
    
    private func installLogoImageView() {
        view.addSubview(logoImageView)
                
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            logoImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func installchatImageView() {
        view.addSubview(chatImageView)
        
        chatImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            chatImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            chatImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func installSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            signInButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signUpButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
