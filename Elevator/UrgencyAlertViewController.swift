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
    override func viewDidLoad() {
        super.viewDidLoad()
        loadToolBar()
    }
    @IBAction func backBtnClick(sender: UIButton) {
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
            default:  fatalError("HYBottomToolBarButtonClickDelegate method go error!")
        }
    }


}