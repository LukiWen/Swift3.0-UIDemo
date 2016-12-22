//
//  LaunchViewController.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/11/29.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import SDWebImage
let SCREEN_SIZE = UIScreen.main.bounds
enum LaunchViewControllerType : Int{
    case ADLaunchViewController//广告类型
    case GreenhandLaunchViewController//轮播图新手导引类型
    case GifBackgroundLaunchViewController//gif图背景类型
    case RollImageLaunchViewController//滚动图片类型
}
class LaunchViewController: UIViewController,UIScrollViewDelegate {

    var endButton : UIButton!//结束引导按钮
    //广告类型控制器相关参数
    var imageURL : String!//广告图片URL
    var placeholderImageName : String!//广告图片未出现之时的占位图,默认为"引导页.png",可自行设置.提高用户体验.
    var adTime : Int = 5//广告页面时间 默认5秒
    var adURL : String!//广告链接地址
    var titleString : String!//广告页面标题
    var isSkip : Bool!
    //新手导引控制器
    //❗️❗️❗️❗️注意:如果同时加载本地图片数组和服务器图片数组,本地图片将不会生效.建议使用本地图片~因为服务器图片可能会造成卡顿,使用户体验效果下降.
    var imageNameArray : [String] = []//加载本地图片数组来完成新手导引图片的加载,图片名称要命名规范
    var imageURLArray : [String] = []//加载图片URL数组来完成新手导引图片的加载,图片地址要命名规范
    var pageControl : UIPageControl!//新手引导页面标记
    //GIF背景控制参数
    var gifImageName : String!//动态图名称
    var gifImageURL : String!//服务器URL
    var frontGifView : UIView!//以动态图为背景的frontView
    var hideEndButton : Bool!//去除跳转按钮，默认为NO
    //滚动图片背景控制器参数
    var rollImageName : String!//滚动图片名称
    var rollImageURl : String!//服务器图片URL
    var frontRollView : UIView!//以滚动视图为背景的view
    
    var mainVC : UIViewController!
    var timer : Timer!
    var timerLable : UILabel!
    var adImageView : UIImageView!
    var timerLableTap : UITapGestureRecognizer!
    var rollImage : UIImage!
    var rollImageView : UIImageView!
    var rollTimer : Timer!
    var vcType : LaunchViewControllerType!
    init(mainVC : UIViewController,viewControllerType : LaunchViewControllerType){
        super.init(nibName: nil, bundle: nil)
        self.mainVC = mainVC
        self.vcType = viewControllerType
        self.isSkip = true
        self.hideEndButton = false
        self.placeholderImageName = "引导页.png"
        self.adImageView = UIImageView.init(frame: SCREEN_SIZE)
//        self.adImageView = UIImageView()
//        self.adImageView.whc_Left(0).whc_Top(0).whc_Right(0).whc_Bottom(0).whc_CenterEqual(self.view)
        self.frontGifView = UIView.init(frame: SCREEN_SIZE)
        self.frontRollView = UIView.init(frame: SCREEN_SIZE)
        if viewControllerType != LaunchViewControllerType.ADLaunchViewController {
            self.loadEndButton()
        }
        if viewControllerType == LaunchViewControllerType.GreenhandLaunchViewController {
            self.loadPageControl()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        if vcType == LaunchViewControllerType.ADLaunchViewController {
            self.loadADImageView()
            self.loadTimerLable()
            self.timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(LaunchViewController.setAppMainViewController), userInfo: nil, repeats: true)
        }
        if vcType == LaunchViewControllerType.GreenhandLaunchViewController {
            self.loadImageScrollView()
        }
        if vcType == LaunchViewControllerType.GifBackgroundLaunchViewController {
            self.loadGifImage()
        }
        if vcType == LaunchViewControllerType.RollImageLaunchViewController {
            self.loadRollImageView()
        }
        
    }
    func skipAppRootMainViewController(){
        self.view.window?.rootViewController = self.mainVC
    }
    //广告======
    func loadADImageView(){
        self.adImageView.frame = CGRect(x:0,y:0,width:SCREEN_SIZE.width,height:SCREEN_SIZE.height)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(LaunchViewController.pushADWebVC))
        self.adImageView.addGestureRecognizer(tap)
        self.adImageView.isUserInteractionEnabled = true
        self.view.addSubview(self.adImageView)
    }
    func loadTimerLable(){
        self.timerLable = UILabel.init(frame: CGRect(x:SCREEN_SIZE.width - 60,y:60,width:40,height:40))
        self.timerLable.backgroundColor = UIColor.gray
        self.timerLable.textColor = UIColor.white
        self.timerLable.textAlignment = .center
        self.timerLable.layer.masksToBounds = true
        self.timerLable.layer.cornerRadius = 20
        self.timerLable.isUserInteractionEnabled = true
        self.timerLable.alpha = 0.5
        self.timerLable.font = UIFont.systemFont(ofSize: 14)
        if self.isSkip == true{
            self.timerLableTap = UITapGestureRecognizer.init(target: self, action: #selector(LaunchViewController.skipAD))
            self.timerLable.addGestureRecognizer(timerLableTap)
        }
    }
    //计时器调取方法
    func setAppMainViewController(){
        if self.isSkip == true {
            self.timerLable.text = "跳过\(self.adTime)"
            self.adTime -= 1
            if self.adTime < 0 {
                self.timer.invalidate()
                self.view.window?.rootViewController = self.mainVC
            }
        }else{
            self.timerLable.text = "剩余\(self.adTime)"
            self.adTime -= 1
            if self.adTime < 0  {
                self.timer.invalidate()
                self.view.window?.rootViewController = self.mainVC
            }
        }
    }
    //获取图片并且启动计时器
    func setImageURL(imageURL: String){
        self.imageURL = imageURL
        self.adImageView.sd_setImage(with: URL.init(string: imageURL), placeholderImage: UIImage.init(named: self.placeholderImageName))
        self.adImageView.sd_setImage(with: URL.init(string: imageURL)) { (image, error, cacheType, imageUrl) in
            self.view.addSubview(self.timerLable)
            self.view.bringSubview(toFront: self.timerLable)
            self.adImageView.image = image
            self.timer.fire()
        }
    }
    //跳转到广告页面
    func pushADWebVC(){
        self.timer.invalidate()
        let launchVC = LaunchWebViewController()
        launchVC.mainViewController = self.mainVC
        if self.titleString != nil {
            launchVC.title = self.titleString
        }
        launchVC.requestURL = self.adURL
        self.present(launchVC, animated: true, completion: nil)
    }
    func loadImageScrollView(){
        let scrollView = UIScrollView.init(frame: SCREEN_SIZE)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        if self.imageURLArray.count == 0 && self.imageNameArray.count != 0 {
            scrollView.contentSize = CGSize(width:SCREEN_SIZE.width * CGFloat(imageNameArray.count),height:SCREEN_SIZE.height)
                        for i in 0..<imageNameArray.count {
                let imageView = UIImageView.init(frame: CGRect(x:SCREEN_SIZE.width * CGFloat(i) ,y:0,width:SCREEN_SIZE.width,height:SCREEN_SIZE.height))
                imageView.image = UIImage.init(named: imageNameArray[i]as String)
                scrollView.addSubview(imageView)
                if i == self.imageNameArray.count - 1 {
                    imageView.addSubview(self.endButton)
                    imageView.isUserInteractionEnabled = true
                }
            }
        }
        if imageURLArray.count != 0 {
            scrollView.contentSize = CGSize(width:SCREEN_SIZE.width * CGFloat(imageURLArray.count),height:SCREEN_SIZE.height)
            for i in 0..<imageURLArray.count {
                let imageView = UIImageView.init(frame: CGRect(x: SCREEN_SIZE.width * CGFloat(i),y:0,width:SCREEN_SIZE.width,height:SCREEN_SIZE.height))
                imageView.sd_setImage(with: URL.init(string: imageURLArray[i]), placeholderImage: nil)
                scrollView.addSubview(imageView)
                if i == imageURLArray.count - 1 {
                    imageView.addSubview(self.endButton)
                }
            }
        }
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        pageControl.numberOfPages = imageNameArray.count
    }
    //跳转按钮
    func loadEndButton(){
        self.endButton = UIButton.init(type: UIButtonType.system)
        self.endButton.frame = CGRect(x:SCREEN_SIZE.size.width/2 - 60,y:SCREEN_SIZE.size.height - 120,width:120,height:30)
        self.endButton.tintColor = UIColor.lightGray
        self.endButton.setImage(UIImage.init(named: "进入应用"), for: UIControlState.normal)
        endButton.addTarget(self, action: #selector(LaunchViewController.skipAD), for: UIControlEvents.touchUpInside)
    }
    func skipAD(){
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
        if self.rollTimer != nil {
            self.rollTimer.invalidate()
            self.rollTimer = nil
        }
        self.view.window?.rootViewController = self.mainVC
    }
    //页面控制器
    func loadPageControl(){
        self.pageControl = UIPageControl.init(frame: CGRect(x:0,y:SCREEN_SIZE.height - 40,width:SCREEN_SIZE.width,height:20))
        self.pageControl.currentPage = 0
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         let currentPage = scrollView.contentOffset.x / SCREEN_SIZE.width
        pageControl.currentPage = Int(currentPage)
    }
    //GIF控制器相关方法
    func loadGifImage(){
        let gifImageView = UIImageView.init(frame: SCREEN_SIZE)
        if self.gifImageURL == nil && self.gifImageName != nil{
            gifImageView.image = UIImage.sd_animatedGIFNamed(self.gifImageName)
        }else{
            gifImageView.sd_setImage(with: URL.init(string: gifImageURL), placeholderImage: nil)
        }
        self.view.addSubview(gifImageView)
        self.frontGifView.backgroundColor = UIColor(red:0.9, green:0.9 , blue:0.9 , alpha:0.5)
        if !self.hideEndButton {
             self.frontGifView.addSubview(self.endButton)
            self.endButton.tintColor = UIColor.blue
        }
        self.view.addSubview(self.frontGifView)
    }
    //滚动图片相关
    func loadRollImageView(){
        if self.rollImageName != nil && self.rollImageURl == nil{
            self.rollImage = UIImage.init(named: self.rollImageName)
            self.addRollImageAndTimer()
        }else{
            downLoadImageWithUrlString(string: rollImageURl)
        }
    }
    func addRollImageAndTimer(){
        if rollImage != nil && rollImage.size.height > rollImage.size.width {
            
        }else{
            rollImageView = UIImageView.init(frame: CGRect(x:0,y:0,width:SCREEN_SIZE.height * rollImage.size.width / rollImage.size.height,height:SCREEN_SIZE.height))
            rollImageView.image = rollImage
            self.rollTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(LaunchViewController.rollImageAction), userInfo: nil, repeats: true)
            self.view.addSubview(rollImageView)
            if !hideEndButton {
                self.frontRollView.addSubview(endButton)
                endButton.tintColor = UIColor.blue
            }
            self.view.addSubview(frontRollView)
            self.rollTimer.fire()
        }
    }
    var rollX = 0
    var isReverse = false
    func rollImageAction(){
        if (CGFloat(rollX - 1) > (SCREEN_SIZE.width - SCREEN_SIZE.size.height * rollImage.size.width / rollImage.size.height) && !isReverse){
            rollX = rollX - 1
            rollImageView.frame = CGRect(x:CGFloat(rollX),y:0,width:SCREEN_SIZE.height * rollImage.size.width / rollImage.size.height,height:SCREEN_SIZE.height)
        }else{
            isReverse = true
        }
        if (rollX + 1) < 0 && isReverse  {
            rollX = rollX + 1
            rollImageView.frame = CGRect(x:CGFloat(rollX),y:0,width:SCREEN_SIZE.height * rollImage.size.width / rollImage.size.height,height:SCREEN_SIZE.height)
        }else{
            isReverse = false
        }
    }
    func downLoadImageWithUrlString(string : String){
        let url = URL.init(string: string)
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url!) { (location, response, error) in
             let tmp = NSData.init(contentsOf: location!)
            let img = UIImage.init(data: tmp as! Data)
            DispatchQueue.main.async(execute: { 
                self.rollImage = img
                self.addRollImageAndTimer()
            })
        }
        task.resume()
    }
    deinit {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
        if self.rollTimer != nil {
            self.rollTimer.invalidate()
            self.rollTimer = nil
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
