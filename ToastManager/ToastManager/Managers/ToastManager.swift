//
//  ToastManager.swift
//  ToastManager
//
//  Created by Ahmed masoud on 4/3/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import UIKit

class ToastManager {
    //MARK: Properties
    static let shared = ToastManager()
    private var view: UIView = UIView()
    private var message: String = ""
    private var bottomAnchor: NSLayoutConstraint!
    private var errorHeaders: [ToastView?] = []
    
    //MARK: Methods
    private init() {}
    
    func showError(message: String, view: UIView) {
        let errorHeader: ToastView? = ToastView()
        errorHeaders.forEach({
            hideBanner(errorHeader: $0)
        })
        errorHeaders.append(errorHeader)
        self.view = view
        self.message = message
        createBannerWithInitialPosition(errorHeader: errorHeader)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.hideBanner(errorHeader: errorHeader)
        }
    }
    
    private func createBannerWithInitialPosition(errorHeader: ToastView?) {
        guard let errorHeader = errorHeader else { return }
        errorHeader.errorLabel.text = message
        errorHeader.layer.cornerRadius = 10
        errorHeader.layer.masksToBounds = true
        view.addSubview(errorHeader)
        let guide = view.safeAreaLayoutGuide
        errorHeader.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor = errorHeader.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 100)
        bottomAnchor.isActive = true
        errorHeader.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -20).isActive = true
        errorHeader.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: 20).isActive = true
        errorHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorHeader.heightAnchor.constraint(equalToConstant: errorHeader.viewHeight).isActive = true
        view.layoutIfNeeded()
        animateBannerPresentation()
    }
    
    private func animateBannerPresentation() {
        if KeyboardStateManager.shared.isVisible {
            bottomAnchor.constant = -KeyboardStateManager.shared.keyboardOffset
        } else {
            bottomAnchor.constant = -20
        }
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: { [weak self] in self?.view.layoutIfNeeded() }, completion: nil)
    }
    
    private func hideBanner(errorHeader: ToastView?) {
        UIView.animate(withDuration: 0.5, animations: {
            errorHeader?.alpha = 0
        }) { _ in
            errorHeader?.removeFromSuperview()
        }
    }
}
