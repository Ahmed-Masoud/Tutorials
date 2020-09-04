//
//  ViewController.swift
//  LocalizationManager
//
//  Created by Ahmed masoud on 8/10/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = "Language Check".localized
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let image = UIImage(named: "arrow")?.imageFlippedForRightToLeftLayoutDirection()
        myImage.image = image
    }
    
    @IBAction func switchLanguage(_ sender: Any) {
        if LocalizationManager.shared.getLanguage() == .Arabic {
            LocalizationManager.shared.setLanguage(language: .English)
        } else {
            LocalizationManager.shared.setLanguage(language: .Arabic)
        }
    }
    

}

