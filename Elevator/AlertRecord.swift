//
//  AlertRecord.swift
//  Elevator
//
//  Created by 郝赟 on 16/6/17.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
import Alamofire
class AlertRecord {
    var id:Int?
    var twoCodeId:String = ""  //URL
    var address:String = ""
    var date:String = ""
    var imgName:String = ""
    //增加记录
    func insertToDb() -> Bool {
        self.date = Constants.curruntTimeString
        return HYDbAlertRecord().insert(self)
    }
    //删除记录
    func deleteFromDb() -> Bool {
        HYImage.shareInstance.deleteFileForName(self.imgName)
        return HYDbAlertRecord().deleteRow(self.id!)
    }
    //更新记录
    func updateDb() -> Bool {
        return HYDbAlertRecord().update(self)
    }
    //查询
    static func selectAll() -> [AlertRecord]{
        return HYDbAlertRecord().getAllAlertRecord()
    }
    static func select(address:String) -> [AlertRecord] {
        return HYDbAlertRecord().getAlertRecordForAddress(address)
    }
    func submit()-> (Bool,String) {
        var isSuccess = false
        var info = "报警失败！"
        if HYNetwork.isConnectToNetwork() {
            let image = HYImage.shareInstance.getImageForName(self.imgName)
            let imgStr:String = HYImage.get64encodingStr(image)
            let fileLen = imgStr.characters.count
            
            guard imgStr != ""  else {
                return (isSuccess,info)
            }
            HYProgress.showWithStatus("正在报警，请稍后！")
            Alamofire.request(.POST, URLStrings.remarkAddMobile, parameters: [
                "TwoCodeId":self.twoCodeId,
                "imgStr":imgStr,
                "fileLen":fileLen
                ]).responseString { response in
                    HYProgress.dismiss()
                    if let backStr = response.result.value {
                        if backStr != "" && backStr != "0" {
                            self.address = backStr
                            isSuccess = true
                            info = "报警成功!"
                        }
                    }
            }
        }
        return (isSuccess,info)
    }

}