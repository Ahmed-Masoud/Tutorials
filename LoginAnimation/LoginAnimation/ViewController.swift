//
//  ViewController.swift
//  LoginAnimation
//
//  Created by Ahmed masoud on 4/11/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingSpinner.isHidden = true
        hideViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateViews()
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        animateLogin()
    }
    
    
    func hideViews() {
        let scaleDownTransform = CGAffineTransform(scaleX: 0, y: 0)
        imageView.transform = scaleDownTransform
        let scaleLeftTransform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        userNameTextField.transform = scaleLeftTransform
        let scaleRightTransform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        passwordTextField.transform = scaleRightTransform
        
    }
    
    func animateViews() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.imageView.transform = .identity // CGAffineTransform(scaleX: 1, y: 1)
                self.userNameTextField.transform = .identity
                self.passwordTextField.transform = .identity
            }
        }
    }
    
    func animateLogin() {
        self.loginButtonTopConstraint.constant = 100
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.loadingSpinner.isHidden = false
            self.loadingSpinner.startAnimating()
        }
    }
}

