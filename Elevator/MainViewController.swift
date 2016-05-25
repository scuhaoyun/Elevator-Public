//
//  MainViewController.swift
//  Elevator
//
//  Created by 郝赟 on 15/12/27.
//  Copyright © 2015年 haoyun. All rights reserved.
//

import UIKit
import Alamofire
import QuartzCore
class MainViewController : UIViewController {
    /**
    *  View生命周期函数
    */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func scanBtnClick(sender: UIButton) {
        let qrcodeViewController = QRScanViewController(completion: {
            QRUrlString in
            if QRUrlString != nil {
                if QRUrlString! == "recordBtnClick" {
                    let recordStoryboard = UIStoryboard(name:"Record", bundle: nil)
                    let  queryRecordViewController = recordStoryboard.instantiateViewControllerWithIdentifier("QueryRecordViewController") as! QueryRecordViewController
                    self.presentViewController(queryRecordViewController, animated: true, completion: nil)
                }
                else {
                    var qrcode = QRcode()
                    qrcode.QRUrlString = QRUrlString!
                    let queryStoryBoard = UIStoryboard(name:"Query", bundle: nil)
                    let queryViewController = queryStoryBoard.instantiateViewControllerWithIdentifier("QueryInfoViewController") as! QueryInfoViewController
                    queryViewController.twoCodeId = qrcode.QR24String
                    queryViewController.qrcodeTitle = qrcode.QR6String
                    self.presentViewController(queryViewController, animated: true, completion: nil)
                    QueryRecord(title:qrcode.QR6String , twoCodeId: qrcode.QR24String).updateDb()
                }
            }
            else {
                let qureyStoryBoard = UIStoryboard(name:"Query", bundle: nil)
                let queryInstallViewController = qureyStoryBoard.instantiateViewControllerWithIdentifier("QueryManualViewController") as! QueryManualViewController
                self.presentViewController(queryInstallViewController, animated: true, completion: nil)
            }
        })
        self.showViewController(qrcodeViewController, sender: nil)
    }
    @IBAction func recordBtnClick(sender: AnyObject) {
        let recordStoryboard = UIStoryboard(name:"Record", bundle: nil)
        let  recordViewController = recordStoryboard.instantiateViewControllerWithIdentifier("RecordViewController") as! RecordViewController
        self.presentViewController(recordViewController, animated: true, completion: nil)
    }
    
    @IBAction func menuBtnClick(sender: AnyObject) {
        let menuStoryboard = UIStoryboard(name:"Menu", bundle: nil)
        let menuViewController = menuStoryboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        self.presentViewController(menuViewController, animated: true, completion: nil)

    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == UIEventSubtype.MotionShake {
            print("Shaked!")
            if HYNetwork.isWifiOpen(){
                let macAddress = HYNetwork.getMacForWifiName("CCDT")
                if let mac = macAddress {
                    Alamofire.request(.GET, URLStrings.queryRegistNmuberByMac, parameters: ["macAdress": mac])
                        .responseString { response in
                            if response.result.isSuccess {
                                let queryStoryBoard = UIStoryboard(name:"Query", bundle: nil)
                                let queryViewController = queryStoryBoard.instantiateViewControllerWithIdentifier("QueryInfoViewController") as! QueryInfoViewController
                                let twoCodeId = response.result.value! + "000000000000000000"
                                queryViewController.twoCodeId = twoCodeId
                                queryViewController.qrcodeTitle = "\(twoCodeId)"
                                self.showViewController(queryViewController, sender: self)
                            }
                    }

                }

            }
        }
    }
}


