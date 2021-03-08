//
//  ViewController.swift
//  ToastManager
//
//  Created by Ahmed masoud on 4/3/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showToast(_ sender: Any) {
        Banner.showMessage(message: textField.text ?? "" , view: self.view, bannerStyle: .default )
    }
    
}

