//
//  ButtonsVC.swift
//  LoginAnimation
//
//  Created by Ahmed masoud on 4/12/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ButtonsVC: UIViewController {

    @IBOutlet weak var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.layer.borderWidth = 2
        circleView.layer.borderColor = UIColor.red.cgColor
        circleView.backgroundColor = .clear
        circleView.layer.cornerRadius = 30
    }
    
    @IBAction func tapACtion(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.circleView.center.x = sender.center.x
        }
    }
    

}
