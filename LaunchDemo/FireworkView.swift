//
//  FireworkView.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/15.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class FireworkView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createFireWorkView()->CAEmitterLayer{
        let caELayer = CAEmitterLayer()
        //发射源
        caELayer.emitterPosition = CGPoint(x:self.frame.size.width / 2,y:self.frame.size.height - 50)
        //发射源尺寸
        caELayer.emitterSize = CGSize(width:50,height:0)
        //模式
        caELayer.emitterMode = kCAEmitterLayerOutline
        //形状
        caELayer.emitterShape = kCAEmitterLayerLine
        //渲染模式
        caELayer.renderMode = kCAEmitterLayerAdditive
        //方向
        caELayer.velocity = 1
        //随机产生粒子
        caELayer.seed = arc4random() % 100 + 1
        let cell = CAEmitterCell()
        //速率
        cell.birthRate = 1.0
        //角度
        cell.emissionRange = 0.11 * CGFloat(M_PI)
        //速度
        cell.velocity = 300
        //范围
        cell.velocityRange = 150
        //Y轴 加速度分量
        cell.yAcceleration = 75
        //周期
        cell.lifetime = 2.04
        //CGImageRef的对象,既粒子要展现的图片
        cell.contents = UIImage.init(named: "FFRing")?.cgImage
        cell.scale = 0.2
        cell.color = UIColor(red:0.6,green:0.6,blue:0.6,alpha:0.8).cgColor
        // 一个粒子的颜色green 能改变的范围
        cell.greenRange                 = 1.0
        // 一个粒子的颜色red 能改变的范围
        cell.redRange                   = 1.0
        // 一个粒子的颜色blue 能改变的范围
        cell.blueRange                  = 1.0
        // 子旋转角度范围
        cell.spinRange                  = CGFloat(M_PI)
        //爆炸
        let burst = CAEmitterCell()
        //系数
        burst.birthRate = 1.0
        //速度
        burst.velocity = 0
        //比例
        burst.scale = 2.5
        // shifting粒子red在生命周期内的改变速度
        burst.redSpeed                  = -1.5
        // shifting粒子blue在生命周期内的改变速度
        burst.blueSpeed                 = +1.5
        // shifting粒子green在生命周期内的改变速度
        burst.greenSpeed                = +1.0
        //生命周期
        burst.lifetime                  = 0.35
        // 火花 and finally, the sparks
        let spark            = CAEmitterCell()
        //粒子产生系数，默认为1.0
        spark.birthRate                 = 400
        //速度
        spark.velocity                  = 125
        // 360 deg//周围发射角度
        spark.emissionRange             = 2 * CGFloat(M_PI)
        // gravity//y方向上的加速度分量
        spark.yAcceleration             = 75
        //粒子生命周期
        spark.lifetime                  = 3
        //是个CGImageRef的对象,既粒子要展现的图片
        spark.contents                  = UIImage.init(named: "FFTspark")?.cgImage
        //缩放比例速度
        spark.scaleSpeed                = -0.2
        //粒子green在生命周期内的改变速度
        spark.greenSpeed                = -0.1
        //粒子red在生命周期内的改变速度
        spark.redSpeed                  = 0.4
        //粒子blue在生命周期内的改变速度
        spark.blueSpeed                 = -0.1
        //粒子透明度在生命周期内的改变速度
        spark.alphaSpeed                = -0.25
        //子旋转角度
        spark.spin                      = 2 * CGFloat(M_PI)
        //子旋转角度范围
        spark.spinRange                 = 2 * CGFloat(M_PI)
        
        caELayer.emitterCells = (NSArray.init(object: cell) as! [CAEmitterCell])
        cell.emitterCells = (NSArray.init(object: burst) as! [CAEmitterCell])
        burst.emitterCells = (NSArray.init(object: spark) as! [CAEmitterCell])
        return caELayer
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
