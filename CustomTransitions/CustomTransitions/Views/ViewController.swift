//
//  ViewController.swift
//  CustomTransitions
//
//  Created by Ahmed masoud on 3/27/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Properties
    let transition = StretchAnimator()
    @IBOutlet weak var searchContainerView: UIView!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK:- Methods
    @IBAction func openDetailVC(_ sender: Any) {
        let vc = DetailVC.create()
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

//MARK:- Transition Delegate Conformance
extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = searchContainerView.frame
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

