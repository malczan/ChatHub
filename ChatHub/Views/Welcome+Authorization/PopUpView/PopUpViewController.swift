//
//  PopUpViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/02/2023.
//

import Foundation
import UIKit
import RxSwift

class PopUpViewController: UIViewController {
    
    var viewModel: PopUpViewModel!
    private let disposeBag = DisposeBag()

    
    private var bottomAnchor: NSLayoutConstraint?
    private var popUpView: PopUpView!
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPopUpWithAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        installPopUpView()
        bind()
    }
    
    private func setupStyle() {
        view.backgroundColor = .clear
    }
    
    private func installPopUpView() {
        popUpView = PopUpView()
        view.addSubview(popUpView)
        
        popUpView.inject(viewModel: viewModel)

        popUpView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomAnchor = popUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 200)
        bottomAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            popUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popUpView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func bind() {
        viewModel
            .hideDriver
            .drive(onNext: { [weak self] in
                self?.hidePopUpWithAnimation()
            })
            .disposed(by: disposeBag)
    }
    
    private func hidePopUpWithAnimation() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut) {
            self.bottomAnchor?.constant = 200
            self.view.backgroundColor = .clear
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.viewModel.dissmisPopUp()
        }
    }
    
    private func showPopUpWithAnimation() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseIn) {
            self.bottomAnchor?.constant = 0
            self.view.backgroundColor = .black.withAlphaComponent(0.4)
            self.view.layoutIfNeeded()
        }
    }
    
}
