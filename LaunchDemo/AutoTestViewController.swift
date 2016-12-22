//
//  AutoTestViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/11/30.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class AutoTestViewController: UIViewController {

    fileprivate let leftTopLable = UILabel()
    fileprivate let rightTopLable = UILabel()
    fileprivate let leftBottomLable = UILabel()
    fileprivate let rightBottomLable = UILabel()
    fileprivate let button = UIButton()
    fileprivate var count : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "AutoTest"
        self.view.addSubview(leftTopLable)
        self.view.addSubview(rightTopLable)
        self.view.addSubview(leftBottomLable)
        self.view.addSubview(rightBottomLable)
        self.view.addSubview(button)
        leftTopLable.whc_Left(0).whc_Top(64).whc_Size(50, height: 50)
        leftBottomLable.whc_Left(0).whc_BaseLine(0).whc_SizeEqual(rightTopLable)
        rightTopLable.whc_Trailing(0).whc_Top(64).whc_SizeEqual(leftTopLable)
        rightBottomLable.whc_Trailing(0).whc_BaseLine(0).whc_SizeEqual(leftBottomLable)
        button.whc_CenterEqual(self.view, offsetX: 0, offsetY: 32).whc_WidthEqual(leftTopLable)
        leftTopLable.backgroundColor = UIColor.blue
        leftBottomLable.backgroundColor = UIColor.red
        rightTopLable.backgroundColor = UIColor.orange
        rightBottomLable.backgroundColor = UIColor.brown
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(animateAction), for: UIControlEvents.touchUpInside)
        
    }

    func animateAction(sender : UIButton){
        count += 1
        if count % 2 != 0 {
            //动态更新约束
            leftTopLable.whc_Trailing(0).whc_BaseLine(0)
            rightTopLable.whc_Left(0).whc_BaseLineEqual(leftTopLable)
            leftBottomLable.whc_TrailingEqual(leftTopLable).whc_Top(64)
            rightBottomLable.whc_LeftEqual(rightTopLable).whc_TopEqual(leftBottomLable)
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }else{
            leftTopLable.whc_Left(100).whc_Top(64)
            leftBottomLable.whc_Left(100).whc_BaseLine(0)
            rightTopLable.whc_Trailing(100).whc_Top(64)
            rightBottomLable.whc_Trailing(100).whc_BaseLine(0)
            UIView.animate(withDuration: 0.5, animations: { 
                self.view.layoutIfNeeded()
            })
        }
        
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
