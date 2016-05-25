//
//  QueryRecordCell.swift
//  Elevator
//
//  Created by 郝赟 on 15/12/29.
//  Copyright © 2015年 haoyun. All rights reserved.
//

import UIKit

protocol RecordCellDelegate:class {
    func RecordCellBtnClick(cell:UITableViewCell,clickBtn:UIButton)
}
class QueryRecordCell: UITableViewCell{
    @IBOutlet weak var checkboxBtn: UIButton!
    @IBOutlet weak var qrcodeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    //用作查询记录时
    var queryRecord:QueryRecord? {
        willSet {
            qrcodeTitleLabel.text = newValue?.title
            timeLabel.text = newValue?.date
        }
    }
    weak var delegate:RecordCellDelegate?
    var checkboxIsSelected: Bool = false {
        willSet{
            if newValue {
                checkboxBtn.setBackgroundImage(UIImage(named: "checkbox_selected.png"), forState:UIControlState.Normal)
            }
            else{
                checkboxBtn.setBackgroundImage(UIImage(named: "checkbox_unselected.png"), forState:UIControlState.Normal)
            }
        }
    }
    @IBAction func editBtnClick(sender: UIButton) {
        delegate?.RecordCellBtnClick(self, clickBtn: sender)
    }

    @IBAction func checkboxClick(sender: UIButton) {
        checkboxIsSelected = !checkboxIsSelected
        delegate?.RecordCellBtnClick(self, clickBtn: sender)
    }
    func alertView(alertView: SwiftAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
    }
}