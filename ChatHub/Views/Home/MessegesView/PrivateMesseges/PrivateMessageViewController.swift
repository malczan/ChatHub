//
//  PrivateMessegeViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 20/05/2023.
//

import UIKit
import RxSwift

class PrivateMessageViewController: UIViewController {
    
    typealias Style = MessagesViewStyle
    
    var viewModel: PrivateMesssageViewModel!

    private var headerView: PrivateMessageHeaderView!
    private var chatContainer = UIView()
    private var chatTableViewController: PrivateMessageTableViewController!
    private let disposeBag = DisposeBag()
    private var footerView: PrivateMessageFooterView!
    private var footerConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        installHeader()
        installFooter()
        installChatContainer()
        installChatTableView()
        observeKeyboard()
    }
        
    private func setupUI() {
        view.backgroundColor = Style.backgroundColor
    }
    
    private func installHeader() {
        headerView = PrivateMessageHeaderView()
        headerView.inject(viewModel: viewModel)
        
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func installChatContainer() {
        view.addSubview(chatContainer)
        
        chatContainer.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            chatContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            chatContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatContainer.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
    }
    
    private func installChatTableView() {
        chatTableViewController = PrivateMessageTableViewController()
        chatTableViewController.inject(viewModel: viewModel)
        
        self.addChild(chatTableViewController)
        chatTableViewController.view.frame = self.chatContainer.frame
        view.addSubview(chatTableViewController.view)
        
        chatTableViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chatTableViewController.view.topAnchor.constraint(equalTo: chatContainer.topAnchor),
            chatTableViewController.view.leadingAnchor.constraint(equalTo: chatContainer.leadingAnchor),
            chatTableViewController.view.trailingAnchor.constraint(equalTo: chatContainer.trailingAnchor),
            chatTableViewController.view.bottomAnchor.constraint(equalTo: chatContainer.bottomAnchor)
        ])
    }
    
    private func installFooter() {
        footerView = PrivateMessageFooterView()
        footerView.inject(viewModel: viewModel)
        
        view.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        footerConstraint = footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        footerConstraint.isActive = true
        
        NSLayoutConstraint.activate([

            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func observeKeyboard() {
        NotificationCenter.default
            .rx
            .notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: {
                [weak self] notification in
                self?.animateFooterUp(after: notification)
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default
            .rx
            .notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: {
                [weak self] notification in
                self?.animateFooterDown(after: notification)
            })
            .disposed(by: disposeBag)
    }
    
    private func animateFooterUp(after notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.size.height
        
        UIView.animate(withDuration: 0.3) {
            self.footerConstraint.constant = -keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateFooterDown(after notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.footerConstraint.constant = -20
            self.view.layoutIfNeeded()
        }
    }

}
