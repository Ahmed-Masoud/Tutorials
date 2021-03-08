//
//  Banner.swift
//  ToastManager
//
//  Created by Ahmed masoud on 4/3/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import UIKit

public enum BannerStyle {
    case danger
    case info
    case customView
    case success
    case warning
    case `default`
}

class Banner: NSObject {
    
    //MARK: Properties
    static var view: UIView = UIView()
    static var message: String = ""
    static var topAnchor: NSLayoutConstraint!
    static var errorHeaders: [ToastView?] = []
    
    //MARK: Methods
    static func showMessage(message: String, view: UIView, bannerStyle: BannerStyle) {
        let messageHeader: ToastView? = ToastView()
        errorHeaders.forEach({
            hideBanner(errorHeader: $0)
        })
        errorHeaders.append(messageHeader)
        self.view = view
        self.message = message
        messageHeader?.errorLabel.font = .boldSystemFont(ofSize: 16)
        
        switch bannerStyle {
        case .danger:
            messageHeader?.contentView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.3176470588, blue: 0.2784313725, alpha: 1)
            messageHeader?.errorLabel.textColor = .white
        case .info:
            messageHeader?.contentView.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.6, blue: 0.8431372549, alpha: 1)
            messageHeader?.errorLabel.textColor = .white
        case .customView:
            messageHeader?.contentView.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.4078431373, blue: 0.5411764706, alpha: 1)
            messageHeader?.errorLabel.textColor = .white
        case .success:
            messageHeader?.contentView.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.7960784314, blue: 0.4705882353, alpha: 1)
            messageHeader?.errorLabel.textColor = .white
        case .warning:
            messageHeader?.contentView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.6588235294, blue: 0.231372549, alpha: 1)
            messageHeader?.errorLabel.textColor = .white
        case .default:
            messageHeader?.contentView.backgroundColor = #colorLiteral(red: 0.200000003, green: 0.200000003, blue: 0.200000003, alpha: 1)
            messageHeader?.errorLabel.textColor = .white
        }
        
        createBannerWithInitialPosition(errorHeader: messageHeader)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.hideBanner(errorHeader: messageHeader)
        }
    }
    
    static func createBannerWithInitialPosition(errorHeader: ToastView?) {
        guard let messageHeader = errorHeader else { return }
        
        messageHeader.errorLabel.text = message
        messageHeader.layer.cornerRadius = 10
        messageHeader.layer.masksToBounds = true
        view.addSubview(messageHeader)
        let guide = view.safeAreaLayoutGuide
        messageHeader.translatesAutoresizingMaskIntoConstraints = false
        topAnchor = messageHeader.topAnchor.constraint(equalTo: guide.topAnchor , constant: -150)
        topAnchor.isActive = true
        messageHeader.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: 0).isActive = true
        messageHeader.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: 0).isActive = true
        messageHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageHeader.heightAnchor.constraint(equalToConstant: messageHeader.viewHeight).isActive = true
        view.layoutIfNeeded()
        animateBannerPresentation()
    }
    
    static func animateBannerPresentation() {
        topAnchor.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: { view.layoutIfNeeded() }, completion: nil)
    }
    
    static func hideBanner(errorHeader: ToastView?) {
        UIView.animate(withDuration: 0.5, animations: {
            errorHeader?.alpha = 0
        }) { _ in
            errorHeader?.removeFromSuperview()
        }
    }
    
}


/*
 //Usaing
    Banner.showMessage(message: "Hello" , view: self.view, bannerStyle: .customView )
 */
