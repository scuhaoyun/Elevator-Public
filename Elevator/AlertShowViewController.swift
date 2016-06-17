
//
//  AlertShowViewController.swift
//  Elevator
//
//  Created by 郝赟 on 16/6/17.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
class AlertShowViewController:UIViewController {
    @IBOutlet weak var twoCodeIdLabel: UILabel!
    @IBOutlet weak var alertInfoLabel: UILabel!
    @IBOutlet weak var alertAddressLabel: UILabel!
    @IBOutlet weak var alertPicView: UIImageView!
    var alertRecord:AlertRecord?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard alertRecord != nil else {
            return
        }
        twoCodeIdLabel.text = alertRecord?.twoCodeId[0...5]
        alertInfoLabel.text = alertRecord?.date
        alertAddressLabel.text = alertRecord?.address
        alertPicView.image = HYImage.shareInstance.getImageForName(alertRecord!.imgName)
    }
    @IBAction func backBtnClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}