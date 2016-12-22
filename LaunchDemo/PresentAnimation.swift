//
//  PresentAnimation.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import Foundation
import pop
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
class PresentAnimation: NSObject,UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view
        
        toView?.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT)
        
        toView?.center = CGPoint(x:transitionContext.containerView.center.x,y:-transitionContext.containerView.center.y)
        
        transitionContext.containerView.addSubview(toView!)
        
        let positionAnimate = POPSpringAnimation.init(propertyNamed: kPOPLayerPositionY)
        positionAnimate?.toValue = transitionContext.containerView.center.y
        positionAnimate?.springBounciness = 10
        transitionContext.completeTransition(true)
        
        let scaleAniamte = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAniamte?.springBounciness = 20
        scaleAniamte?.fromValue = NSValue.init(cgPoint: CGPoint(x:1.2,y:1.4))
        toView?.layer.pop_add(positionAnimate, forKey: "positionAnimation")
        toView?.layer.pop_add(scaleAniamte, forKey: "scaleAnimation")
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
}
