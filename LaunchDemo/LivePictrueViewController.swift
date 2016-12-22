//
//  LivePictrueViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/19.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class LivePictrueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView.init(frame: self.view.bounds)
        imageView.image = UIImage.init(named: "darong")
        self.view.addSubview(imageView)
        let timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(showLoveHeartView), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
        // Do any additional setup after loading the view.
    }

    func showLoveHeartView(){
        let heart = AnimationView.init(frame: CGRect(x:0,y:0,width:40,height:40))
        self.view.addSubview(heart)
        let fountainSource = CGPoint(x:self.view.frame.size.width - 80,y:self.view.bounds.size.height - 30 / 2.0 - 10)
        heart.center = fountainSource
        let count = Int(round(Double(arc4random() % 12)))
        heart.animatePictureInView(view: self.view, image: UIImage.init(named: "resource.bundle/heart\(count).png")!)
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
