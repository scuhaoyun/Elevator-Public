//
//  AlertRecordCell.swift
//  Elevator
//
//  Created by 郝赟 on 16/6/17.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
class AlertRecordCell:UITableViewCell {
    @IBOutlet weak var checkboxBtn: UIButton!
    @IBOutlet weak var qrcodeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    var alertRecord:AlertRecord? {
        willSet {
            qrcodeLabel.text = newValue?.twoCodeId
            timeLabel.text = newValue?.date
            addressLabel.text = newValue?.address
        }
    }
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
    
    @IBAction func checkboxClick(sender: UIButton) {
        checkboxIsSelected = !checkboxIsSelected
    }

}