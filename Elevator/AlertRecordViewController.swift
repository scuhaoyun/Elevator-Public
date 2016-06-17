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
    var alertRecordData:[AlertRecord] = [] {
        didSet {
            tableview.reloadData()
        }
    }
    override func viewDidLoad() {
         super.viewDidLoad()
         tableview.delegate = self
        tableview.dataSource = self
        //tableview.estimatedRowHeight = 53
        alertRecordData = AlertRecord.selectAll()
        loadToolBar()
    }
    /**
     *  协议方法
     */
    func toolBarButtonClicked(sender: UIButton) {
        switch sender.currentTitle! {
        case "返回" :
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
    /**
     *tableView所需实现的协议方法
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertRecordData.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 53
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier   = "AlertRecordCell"
        var cell         = tableview.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            var array        = NSBundle.mainBundle().loadNibNamed("AlertRecordCell", owner: self, options: nil)
            let newCell      = array[0] as! AlertRecordCell
            newCell.alertRecord = alertRecordData[indexPath.row]
            cell             = newCell
        }
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertStoryBoard = UIStoryboard(name:"Alert", bundle: nil)
        let alertViewController = alertStoryBoard.instantiateViewControllerWithIdentifier("AlertShowViewController") as! AlertShowViewController
        alertViewController.alertRecord = (tableView.cellForRowAtIndexPath(indexPath) as! AlertRecordCell).alertRecord
        self.showViewController(alertViewController, sender: self)
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
        newToolBar.secondButton.hidden = true
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
    
    func removeBtnOnToolBarClick() {
        let alertController = UIAlertController(title: "温馨提示", message: "确定删除吗？", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler:{
            (action: UIAlertAction!) -> Void in
            var isAllSuccess = true
            var haveSelected = false
            for cell in self.tableview.visibleCells {
                let alertCell = cell  as! AlertRecordCell
                if alertCell.checkboxIsSelected {
                    haveSelected = true
                    let record = self.alertRecordData[self.tableview.indexPathForCell(alertCell)!.row]
                    if !record.deleteFromDb() {
                        isAllSuccess = false
                    }
                }
            }
            if haveSelected {
                if isAllSuccess {
                    HYProgress.showSuccessWithStatus("删除成功！")
                }
                else {
                    HYProgress.showErrorWithStatus("操作失败！")
                }
                self.alertRecordData = AlertRecord.selectAll()
            }
            else {
                HYProgress.showErrorWithStatus("未选择删除对象！")
            }
            
        })
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
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
                let alertCell = cell  as! AlertRecordCell
                alertCell.checkboxIsSelected = isSelect
            }
            
        }
        
    }
    
    
    /**
    *  其他：如扩展等
    */

}