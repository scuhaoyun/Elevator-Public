//
//  SetupViewController.swift
//  Elevator
//
//  Created by 郝赟 on 16/7/11.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
class SetupViewController:UIViewController,HYBottomToolBarButtonClickDelegate {
    @IBOutlet weak var applicationAddressTxt: UITextField!
    @IBOutlet weak var applicationPortTxt: UITextField!
    @IBOutlet weak var bottomToolBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadToolBar()
        loadSetupInfo()
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    /**
     *  协议方法
     */
    func toolBarButtonClicked(sender: UIButton) {
        switch sender.currentTitle! {
            case "返回":break
            case "提交":saveData()
                /**
                *  返回的主菜单
                */
            default:  fatalError("HYBottomToolBarButtonClickDelegate method go error!")
        }
    }
    /**
     *  自定义函数
     */
    func loadToolBar(){
        var array1               = NSBundle.mainBundle().loadNibNamed("HYBottomToolBar", owner: self, options: nil) as! [HYBottomToolBar]
        let newToolBar1          = array1[0]
        newToolBar1.delegate     = self
        newToolBar1.frame.size   = bottomToolBar.frame.size
        newToolBar1.frame.origin = CGPoint(x: 0, y: 0)
        newToolBar1.firstButton.setTitle("返回", forState: UIControlState.Normal)
        newToolBar1.secondButton.setTitle("提交", forState: UIControlState.Normal)
        bottomToolBar.addSubview(newToolBar1)
    }
    func loadSetupInfo(){
         self.applicationAddressTxt.text = HYDefaults[.applicationAddress] ?? "cddt.zytx-robot.com"
         self.applicationPortTxt.text = HYDefaults[.applicationPort] ?? "80"
    }
    
    func saveData(){
        HYDefaults[.applicationAddress] = self.applicationAddressTxt.text!
        HYDefaults[.applicationPort] = self.applicationPortTxt.text!
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func dismissKeyboard(){
        self.applicationAddressTxt.resignFirstResponder()
        self.applicationPortTxt.resignFirstResponder()
    }
}