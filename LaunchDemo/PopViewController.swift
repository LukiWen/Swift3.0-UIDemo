//
//  PopViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/20.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button1 = UIButton.init(type: .custom)
        button1.frame = CGRect(x:self.view.center.x - 50,y:100,width:100,height:30)
        button1.backgroundColor = UIColor.cyan
        self.view.addSubview(button1)
        button1.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        let button2 = UIButton.init(type: .custom)
        button2.frame = CGRect(x:self.view.center.x - 50,y:200,width:100,height:30)
        button2.backgroundColor = UIColor.cyan
        self.view.addSubview(button2)
        button2.addTarget(self, action: #selector(clickButton2), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func click(){
        let view = PopView.init(frame: CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height))
        view.fly_h = 350
        view.fly_w = SCREEN_WIDTH
        let iamge = UIImageView.init(frame: CGRect(x:0,y:0,width:view.fly_w,height:view.fly_h))
        iamge.image = UIImage.init(named: "aoliao01.jpg")
        self.view.addSubview(view)
        view.flyView.addSubview(iamge)
        view.startFly(type: FlyType.flyTypeUPToDown)
    }
    func clickButton2(){
        let view = PopView.init(frame: CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height))
        view.fly_h = 350
        view.fly_w = SCREEN_WIDTH
        let imagev = UIImageView.init(frame: CGRect(x:0,y:0,width:view.fly_w,height:view.fly_h))
        imagev.image = UIImage.init(named: "aoliao02.jpg")
        self.view.addSubview(view)
        view.flyView.addSubview(imagev)
        view.startFly(type: .flyTypeDownToUp)
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
