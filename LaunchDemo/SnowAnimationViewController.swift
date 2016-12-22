//
//  SnowAnimationViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/19.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class SnowAnimationViewController: UIViewController {

    var layer : CALayer!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        //粒子layer
        let snowEmitter = CAEmitterLayer()
        //粒子发送位置
        snowEmitter.emitterPosition = CGPoint(x:120,y:0)
        //发射源尺寸
        snowEmitter.emitterSize = self.view.bounds.size
        //发射模式
        snowEmitter.emitterMode = kCAEmitterLayerSurface
        //形状
        snowEmitter.emitterShape = kCAEmitterLayerLine
        //创建雪花类型的粒子
        let snowFlake = CAEmitterCell()
        snowFlake.name = "snow"
        //粒子参数的速度乘数因子
        snowFlake.birthRate = 20.0
        snowFlake.lifetime = 120.0
        snowFlake.velocity = 10.0
        //粒子的速度范围
        snowFlake.velocityRange = 10
        //粒子Y方向的加速度分量
        snowFlake.yAcceleration = 2
        //周围的发射角度
        snowFlake.emissionRange = CGFloat(Float(0.5 * M_PI))
        //子旋转角度范围
        snowFlake.spinRange = CGFloat(Float(0.25 * M_PI))
        snowFlake.contents = UIImage.init(named: "snow")?.cgImage
        //设置雪花形状的粒子的颜色
        snowFlake.color = UIColor.white.cgColor
        snowFlake.redRange = 1.5
        snowFlake.greenRange = 2.2
        snowFlake.blueRange = 2.2
        snowFlake.scaleRange = 0.6
        snowFlake.scale = 0.7
        
        snowEmitter.shadowOpacity = 1.0
        snowEmitter.shadowRadius = 0.0
        snowEmitter.shadowOffset = CGSize(width:0.0,height:0.0)
        
        //粒子边缘的颜色
        snowEmitter.shadowColor = UIColor.white.cgColor
        //添加粒子
        snowEmitter.emitterCells = [snowFlake]
        self.view.layer.addSublayer(snowEmitter)
        
        //形成遮罩
        let image = UIImage.init(named: "alpha")
        layer = CALayer()
        layer.frame = CGRect.init(origin: CGPoint.zero, size: self.view.bounds.size)
        layer.contents = image?.cgImage
        layer.position = self.view.center
        snowEmitter.mask = layer

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
