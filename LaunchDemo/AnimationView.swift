//
//  AnimationView.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/19.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class AnimationView: UIView {

    var imageView : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView.init(frame: frame)
        self.addSubview(imageView)
    }
    func animatePictureInView(view: UIView,image: UIImage){
        imageView.image = image
        
        let totalAnimationDuration = Int(8)

        
        let heartSize = CGFloat(40.0)
        let heartCentreX = self.center.x
        let viewHeight = view.frame.size.height
        
        self.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 0.9
        }, completion: nil)
        
        let i = arc4random_uniform(2)
        let rotationDirection = 1 - (2 * Int(i))
        let rotationFraction = arc4random_uniform(10)
        UIView.animate(withDuration: TimeInterval(totalAnimationDuration), animations: {
            self.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double(rotationDirection) * M_PI / (16 + Double(rotationFraction) * 0.2)))
        }, completion: nil)
        let heartTravelPath = UIBezierPath()
        heartTravelPath.move(to: self.center)
        
        let endPoint = CGPoint(x:heartCentreX + CGFloat(rotationDirection) * CGFloat(2.0) * heartSize ,y:CGFloat(UInt32(viewHeight / 6.0) + arc4random_uniform(UInt32(viewHeight / 4.0))))
        let j = arc4random_uniform(2)
        let travelDirection = 1 - (2 * Int(j))
        
        let xDelta = (heartSize / 2.0 + 2 * heartSize) * CGFloat(travelDirection)
        let yDelta = max(endPoint.y, max(CGFloat(arc4random_uniform(UInt32(CGFloat(8 * heartSize)))), heartSize))
        let pointOne = CGPoint(x:heartCentreX + CGFloat(xDelta),y:viewHeight - yDelta)
        let pointTwo = CGPoint(x:heartCentreX - CGFloat(2 * xDelta),y:yDelta)
        heartTravelPath.addCurve(to: endPoint, controlPoint1: pointOne, controlPoint2: pointTwo)
        let keyFrameAnimation = CAKeyframeAnimation.init(keyPath: "position")
        keyFrameAnimation.path = heartTravelPath.cgPath
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)]
        keyFrameAnimation.duration = CFTimeInterval(totalAnimationDuration + Int(endPoint.y / viewHeight))
        self.layer.add(keyFrameAnimation, forKey: "positionOnPath")
        UIView.animate(withDuration:  TimeInterval(totalAnimationDuration), animations: {
            self.alpha = 0.0
        }, completion: {(rst) in
            self.removeFromSuperview()
        })
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
