//
//  ViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/11/29.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerPreviewingDelegate {

    fileprivate let contents = ["AutoTest","UIStackViewTest","自动计算cell","动态修改xib","烟花动画","弹幕","雪花","直播动画","自定义转场动画","直播点赞","PopView","波浪动画","导航栏渐变/图片下拉放大"]
    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "AutoLayoutTest"
        tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
         self.view.addSubview(tableView)
        tableView.whc_Left(0).whc_Right(0).whc_Top(0).whc_Bottom(0)
       
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if #available(iOS 9.0, *) {
            _ = self.tableView.indexPath(for: previewingContext.sourceView as! UITableViewCell)
            let autoVC = AutoCellHeightVC()
            return autoVC
        } else {
            let autoVC = AutoCellHeightVC()
            return autoVC
        }
    }
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var VC: UIViewController!
        if indexPath.row == 0 {
            VC = AutoTestViewController()
        }
        if indexPath.row == 1 {
            VC = UIStackViewTestVC()
        }
        if indexPath.row == 2 {
            VC = AutoCellHeightVC()
        }
        if indexPath.row == 3 {
            VC = AutoXibVC()
        }
        if indexPath.row == 4 {
            VC = FireworksViewController()
        }
        if indexPath.row == 5 {
            VC = ScrollLableViewController()
        }
        if indexPath.row == 6 {
            VC = SnowAnimationViewController()
        }
        if indexPath.row == 7 {
            VC = LivePictrueViewController()
        }
        if indexPath.row == 8 {
            VC = FromViewController()
        }
        if indexPath.row == 9 {
            VC = LiveLoveHeartViewController()
        }
        if indexPath.row == 10 {
            VC = PopViewController()
        }
        if indexPath.row == 11 {
            VC = WaveAnimationViewController()
        }
        if indexPath.row == 12 {
            VC = Nav_PullImageViewController()
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
extension ViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentify = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentify)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: indentify)
        }
        cell?.textLabel?.text = contents[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 17)
        if self.responds(to: #selector(getter: traitCollection)) {
            if #available(iOS 9.0, *) {
                if self.traitCollection.responds(to: #selector(getter: self.traitCollection.forceTouchCapability)) {
                        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                            self.registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: cell!)
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        return cell!
    }
}

