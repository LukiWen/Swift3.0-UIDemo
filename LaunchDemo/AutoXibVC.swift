//
//  AutoXibVC.swift
//  LaunchDemo
//
//  Created by wzdg-whl on 16/11/30.
//  Copyright © 2016年 WHL. All rights reserved.
//

import UIKit
import SDWebImage
class AutoXibVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate{

    
    @IBOutlet weak var testImageV: UIImageView!
    var testView : UIImageView!
    var actionSheet : UIActionSheet!
    var sourceType : UIImagePickerControllerSourceType!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testView = UIImageView.init(frame: self.view.bounds)
        self.testView.backgroundColor = UIColor.red
        let tapImg = UITapGestureRecognizer.init(target: self, action: #selector(changeImg))
        self.testView.isUserInteractionEnabled = true
        self.testView.addGestureRecognizer(tapImg)
        self.view.addSubview(self.testView)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(AutoXibVC.changeBackImage))
        self.testImageV.isUserInteractionEnabled = true
        self.testImageV.addGestureRecognizer(tap)
    }
    func changeImg(tap : UITapGestureRecognizer){
        self.view.tag = 111
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.actionSheet = UIActionSheet.init(title: "选择图像", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照","从相册中选择")
        }else{
            self.actionSheet = UIActionSheet.init(title: "选择图像", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选择")
        }
        self.actionSheet.show(in: self.view)
    }
    func changeBackImage(long : UITapGestureRecognizer){
        self.view.tag = 222
        if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.actionSheet = UIActionSheet.init(title: "选择图像", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照","从相册中选择")
        }else{
            self.actionSheet = UIActionSheet.init(title: "选择图像", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选择")
        }
        self.actionSheet.show(in: self.view)
    }
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            switch buttonIndex {
            case 0:
                return
            case 1:
                self.sourceType = UIImagePickerControllerSourceType.photoLibrary
            case 2:
                self.sourceType = UIImagePickerControllerSourceType.camera
            default:
                break
            }
            let pic = UIImagePickerController()
            pic.sourceType = self.sourceType
            pic.delegate = self
            self.present(pic, animated: true, completion: nil)

        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true) { 
            
        }
        let image = info[UIImagePickerControllerOriginalImage]
        switch self.view.tag {
        case 111:
            self.testView.image = image as! UIImage?
        case 222:
            self.testImageV.image = image as! UIImage?
        default:
            break
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testImageV.whc_Height(self.view.frame.height - 64).whc_Width(self.view.frame.width).whc_CenterEqual(self.view).whc_Top(64)
        UIView.animate(withDuration: 0.5) { 
            self.view.layoutIfNeeded()
        }
        self.testView.whc_Left(10).whc_Top(64).whc_Width(50).whc_Height(50)
        self.testView.layer.cornerRadius = 25
        self.testView.layer.masksToBounds = true
        UIView.animate(withDuration: 0.3) { 
            self.view.layoutIfNeeded()
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
