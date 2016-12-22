//
//  Nav&PullImageViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/12/21.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit

class Nav_PullImageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "我的"
        createTableView()
        createHeadView()
        createNavView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    func createTableView(){
        self.tableView = UITableView.init(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:self.view.frame.height ), style: .plain)
        let headViewH = UIScreen.main.bounds.width / 320 * 300
        tableView.contentInset = UIEdgeInsetsMake(headViewH , 0, 0, 0)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    func createHeadView(){
        headImageView = UIImageView()
        let headViewH = UIScreen.main.bounds.width / 320 * 200
        headImageView.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:headViewH)
        headImageView.contentMode = UIViewContentMode.scaleAspectFill
        headImageView.clipsToBounds = true
        headImageView.image = UIImage.init(named: "head.png")
        self.view.addSubview(headImageView)
    }
    func createNavView(){
        navView = UIView.init(frame: CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:64))
        navView.backgroundColor = UIColor.black
        navView.clipsToBounds = true
        titleLable = UILabel()
        titleLable.center.x = UIScreen.main.bounds.width * 0.5
        titleLable.bounds = CGRect(x:0,y:0,width:150,height:44)
        titleLable.textAlignment = .center
        titleLable.font = UIFont.systemFont(ofSize: 16)
        titleLable.textColor = UIColor.white
        titleLable.numberOfLines = 0
        titleLable.text = "HAHA\nlala"
        navView.addSubview(titleLable)
        let button = UIButton.init(type: .custom)        
        button.setTitle("返回", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        navView.addSubview(button)
        button.alpha = 1.0
        button.whc_Left(0).whc_Top(32).whc_Width(60).whc_Height(20)
        button.addTarget(self, action: #selector(popToUpVC), for: .touchUpInside)
        self.view.addSubview(navView)
    }
    func popToUpVC(sender: UIButton){
        _ = self.navigationController?.popViewController(animated: true)
    }
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    lazy var headImageView : UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    lazy var navView : UIView = {
        let navView = UIView()
        return navView
    }()
    lazy var titleLable : UILabel = {
        let titleLable = UILabel()
        return titleLable
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension Nav_PullImageViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "测试测试测试\(indexPath.row)"
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}
extension Nav_PullImageViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.y
        let headImgH = UIScreen.main.bounds.width / 320 * 300
        let offset = headImgH + offsetX
        self.navView.alpha = offset / 250
        if self.navView.alpha >= 1 {
            self.navView.alpha = 1.0
        }
        self.titleLable.frame.origin.y = 64 - 44 * self.navView.alpha
        self.headImageView.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:headImgH - offset)
    }
}
