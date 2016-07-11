//
//  MenuViewController.swift
//  Elevator
//
//  Created by 郝赟 on 16/5/18.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
class MenuViewController:UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.separatorInset = UIEdgeInsetsZero
        tableview.layoutMargins = UIEdgeInsetsZero
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var text = ""
        let cell = UITableViewCell()
        switch indexPath.row {
            case 0: text = "服务器地址设置"
            case 1: text = "关于"
            case 2: text = "帮助"
            default: text = ""
        }
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.systemFontOfSize(17)
        //cell.backgroundColor = UIColor.grayColor()
        cell.separatorInset = UIEdgeInsetsZero
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var title = ""
        var message = ""
        switch indexPath.row {
            case 0:
                let menuStoryBoard = UIStoryboard(name:"Menu", bundle: nil)
                let setupViewController = menuStoryBoard.instantiateViewControllerWithIdentifier("SetupViewController") as! SetupViewController
                self.showViewController(setupViewController, sender: self)
            case 1: title = "关于"; message = "电梯安全公共服务平台公众版    版本号:1.1"
            case 2: title = "帮助"; message = "有任何问题可关注我们的官方网站及问题反馈"
            default: break
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Cancel, handler:nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    @IBAction func backBtnClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }

}