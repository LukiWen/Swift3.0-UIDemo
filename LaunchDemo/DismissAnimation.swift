//
//  DismissAnimation.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import Foundation
import pop
class DismissAnimation: NSObject,UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let offScreenAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerPositionY)
        offScreenAnimation?.toValue = 0 - (fromVC?.view.layer.position.y)!
        transitionContext.completeTransition(true)
        fromVC?.view.layer.pop_add(offScreenAnimation, forKey: "offscreenAnimation")
        
        
        
        
        
        
        
        
        
    }
}
