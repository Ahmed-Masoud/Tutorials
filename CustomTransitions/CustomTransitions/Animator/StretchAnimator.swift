//
//  StretchAnimator.swift
//  CustomTransitions
//
//  Created by Ahmed masoud on 3/27/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class StretchAnimator: NSObject {
    //MARK:- Properties
    private let duration = 0.8
    var presenting = true
    var originFrame = CGRect.zero
}

// MARK:-  Transition Animation Delegate conformance
extension StretchAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let detailView = presenting ? toView : transitionContext.view(forKey: .from)!
        let initialFrame = presenting ? originFrame : detailView.frame
        let finalFrame = presenting ? detailView.frame : originFrame
        
        let xScaleFactor = presenting ?
          initialFrame.width / finalFrame.width :
          finalFrame.width / initialFrame.width

        let yScaleFactor = presenting ?
          initialFrame.height / finalFrame.height :
          finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)

        if presenting {
          detailView.transform = scaleTransform
          detailView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
          detailView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(detailView)

        UIView.animate(
          withDuration: duration,
          delay:0.0,
          animations: { [weak self] in
            guard let self = self else { return }
            detailView.transform = self.presenting ? .identity : scaleTransform
            detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
          }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
