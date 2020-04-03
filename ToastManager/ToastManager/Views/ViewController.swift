//
//  ViewController.swift
//  ToastManager
//
//  Created by Ahmed masoud on 4/3/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showToast(_ sender: Any) {
        ToastManager.shared.showError(message: "Hello", view: self.view)
    }
    
}

