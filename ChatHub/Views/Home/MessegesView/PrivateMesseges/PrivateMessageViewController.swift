//
//  PrivateMessegeViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 20/05/2023.
//

import UIKit
import RxSwift

class PrivateMessageViewController: UIViewController {
    
    typealias Style = MessegasViewStyle
    
    var viewModel: PrivateMesssageViewModel!
    
    let addButton = UIBarButtonItem(title: "Add")
    
    private var footerConstraint = NSLayoutConstraint()
    
    private let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        installHeader()
        installFooter()
        observeKeyboard()
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
    
    private func setupUI() {
        view.backgroundColor = Style.backgroundColor
    }
    
    private func installHeader() {
        let headerView = PrivateMessageHeaderView()
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
    
    private func installFooter() {
        let footerView = PrivateMessageFooterView()
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
