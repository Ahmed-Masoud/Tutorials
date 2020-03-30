//
//  DetailVC.swift
//  CustomTransitions
//
//  Created by Ahmed masoud on 3/27/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func create() -> DetailVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(DetailVC.self)") as! DetailVC
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    @IBAction func dismissVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
