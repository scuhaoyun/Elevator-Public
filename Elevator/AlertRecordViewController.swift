//
//  AlertRecordViewController.swift
//  Elevator
//
//  Created by 郝赟 on 16/5/17.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
class AlertRecordViewController:UIViewController,HYBottomToolBarButtonClickDelegate,SwiftAlertViewDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
         super.viewDidLoad()
         tableview.delegate = self
        tableview.dataSource = self
        loadToolBar()
    }
    /**
     *  协议方法
     */
    func toolBarButtonClicked(sender: UIButton) {
        switch sender.currentTitle! {
        case "返回" :
            break
        case "筛选":filterBtnOnToolBarClick()
            break
        case "全选" :selectBtnOnToolBarClick(sender)
            break
        case "取消全选" :selectBtnOnToolBarClick(sender)
            break
        case "删除":removeBtnOnToolBarClick()
        
            break
        default:  fatalError("HYBottomToolBarButtonClickDelegate method go error!")
        }
    }
    func RecordCellBtnClick(cell: UITableViewCell, clickBtn: UIButton) {
    }
    //SwiftAlertViewDelegate协议方法
    func alertView(alertView: SwiftAlertView, clickedButtonAtIndex buttonIndex: Int){
    }
    
    /**
     *tableView所需实现的协议方法
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    /**
     *  自定义函数
     */
    func loadToolBar(){
        var array                = NSBundle.mainBundle().loadNibNamed("HYBottomToolBar", owner: self, options: nil) as! [HYBottomToolBar]
        let newToolBar           = array[0]
        newToolBar.delegate      = self
        newToolBar.frame.size    = topBarView.frame.size
        newToolBar.frame.origin  = CGPoint(x: 0, y: 0)
        newToolBar.firstButton.setTitle("返回", forState: UIControlState.Normal)
        newToolBar.secondButton.setTitle("筛选", forState: UIControlState.Normal)
        topBarView.addSubview(newToolBar)
        
        var array1               = NSBundle.mainBundle().loadNibNamed("HYBottomToolBar", owner: self, options: nil) as! [HYBottomToolBar]
        let newToolBar1          = array1[0]
        newToolBar1.delegate     = self
        newToolBar1.frame.size   = bottomBarView.frame.size
        newToolBar1.frame.origin = CGPoint(x: 0, y: 0)
        newToolBar1.firstButton.setTitle("全选", forState: UIControlState.Normal)
        newToolBar1.secondButton.setTitle("删除", forState: UIControlState.Normal)
        print(bottomBarView.frame)
        print(self.view.frame)
        bottomBarView.addSubview(newToolBar1)
    }
    func filterBtnOnToolBarClick() {
    }
    func removeBtnOnToolBarClick() {
    }
    func selectBtnOnToolBarClick(sender: UIButton) {
        var isSelect = false
        if tableview.visibleCells.count > 0 {
            if sender.currentTitle == "全选" {
                sender.setTitle("取消全选", forState: UIControlState.Normal)
                isSelect = true
            }
            else {
                sender.setTitle("全选", forState: UIControlState.Normal)
            }
            for cell in tableview.visibleCells {
                let queryCell = cell  as! QueryRecordCell
                queryCell.checkboxIsSelected = isSelect
            }
            
        }
        
    }
    
    
    /**
    *  其他：如扩展等
    */

}