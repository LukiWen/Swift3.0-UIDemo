//
//  LaunchWebViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/11/29.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import WebKit
class LaunchWebViewController: UIViewController ,WKNavigationDelegate{

    var webView : WKWebView!
    var activityView : UIActivityIndicatorView!
    var requestURL : String!
    var navigationView : UIView!
    var titleString : String!
    var mainViewController : UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadNavView()
        let config = WKWebViewConfiguration()
        config.selectionGranularity = WKSelectionGranularity.character
        self.webView = WKWebView.init(frame: CGRect(x:0,y:64,width:SCREEN_SIZE.width,height:SCREEN_SIZE.height - 64), configuration: config)
        self.webView.scrollView.bounces = false
        self.webView.load(URLRequest(url:URL(string: self.requestURL)!))
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        self.loadActivityIndicatorView()
    }

    func loadActivityIndicatorView(){
        self.activityView = UIActivityIndicatorView.init(frame: CGRect(x:20,y:20,width:100,height:100))
        self.activityView.center = self.view.center
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(self.activityView)
        self.view.bringSubview(toFront: self.activityView)
        self.activityView.startAnimating()
        self.activityView.color = UIColor.lightGray
    }
    func loadNavView(){
        self.navigationView = UIView.init(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:64))
        self.navigationView.backgroundColor = UIColor.black
        self.view.addSubview(self.navigationView)
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0,y:navigationView.frame.height - 30,width:50,height:20)
        button.setTitle("关闭", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.init(name: "Helvetica-Bold", size: 14)
        button.addTarget(self, action: #selector(LaunchWebViewController.setMainViewController), for: UIControlEvents.touchUpInside)
        self.navigationView.addSubview(button)
        let lable = UILabel.init(frame: CGRect(x:65,y:20,width:self.view.frame.width - 130,height:44))
        if self.titleString == nil {
            lable.text = "广告"
        }else{
            lable.text = self.titleString
        }
        lable.textColor = UIColor.white
        lable.textAlignment = .center
        lable.font = UIFont.init(name: "Helvetica-Bold", size: 18)
        self.navigationView.addSubview(lable)
        
    }
    func setMainViewController(){
        self.view.window?.rootViewController = self.mainViewController
        navigationView.removeFromSuperview()
        webView.removeFromSuperview()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityView.stopAnimating()
        self.activityView.removeFromSuperview()
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
