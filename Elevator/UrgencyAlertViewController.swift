//
//  UrgencyAlertViewController.swift
//  Elevator
//
//  Created by 郝赟 on 16/5/18.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
class UrgencyAlertViewController:UIViewController,HYBottomToolBarButtonClickDelegate {
    @IBOutlet weak var pictureContainerView: UIView!
    @IBOutlet weak var bottomToolBar: UIView!
    @IBOutlet weak var picImageView: UIImageView!
    var alertRecord:AlertRecord?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadToolBar()
    }
    @IBAction func backBtnClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func loadToolBar(){
        var array                = NSBundle.mainBundle().loadNibNamed("HYBottomToolBar", owner: self, options: nil) as! [HYBottomToolBar]
        let newToolBar           = array[0]
        newToolBar.delegate      = self
        newToolBar.frame.size    = bottomToolBar.frame.size
        newToolBar.frame.origin  = CGPoint(x: 0, y: 0)
        newToolBar.firstButton.setTitle("照相", forState: UIControlState.Normal)
        newToolBar.secondButton.setTitle("报警", forState: UIControlState.Normal)
        bottomToolBar.addSubview(newToolBar)
    }
    /**
     *  协议方法
     */
    func toolBarButtonClicked(sender: UIButton) {
        switch sender.currentTitle! {
            case "返回" : break
            case "照相" : takePhoto(sender, croppringEnabled: false)
            case "报警" : alertSubmit()
            default:  fatalError("HYBottomToolBarButtonClickDelegate method go error!")
        }
    }
    func takePhoto(sender:UIButton,croppringEnabled:Bool){
        let qrviewcontroller = ALCameraViewController(croppingEnabled: croppringEnabled, completion:{
            image in
            if image != nil {
                //如果设置了图片，将button的tag设为111
               self.picImageView.image = image
            }
        })
        self.presentViewController(qrviewcontroller, animated: true, completion: nil)
    }
    func alertSubmit(){
        guard alertRecord != nil else {
            HYProgress.showErrorWithStatus("电梯信息有误，请重新操作后提交！")
            return
        }
        if self.picImageView.image != nil {
           alertRecord!.imgName = HYImage.shareInstance.imageToSave(self.picImageView.image!)!
        }
        let (isSuccess,info) = alertRecord!.submit()
        if isSuccess {
            HYProgress.showSuccessWithStatus(info)
            alertRecord!.insertToDb()
        }
        else {
            HYProgress.showErrorWithStatus(info)
        }
        //alertRecord!.insertToDb()
    }



}