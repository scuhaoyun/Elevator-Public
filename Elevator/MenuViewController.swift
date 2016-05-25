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
        cell.backgroundColor = UIColor.grayColor()
        cell.separatorInset = UIEdgeInsetsZero
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    @IBAction func backBtnClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}