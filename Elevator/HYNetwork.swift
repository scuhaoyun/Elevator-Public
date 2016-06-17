//
//  HYNetwork.swift
//  Elevator
//
//  Created by 郝赟 on 16/1/8.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
import NetworkExtension
import SystemConfiguration
class HYNetwork: NSObject {
    class func isConnectToNetwork() -> Bool {
        return isConnectToNetwork(UIViewController.getCurruntVC())
    }
    class func isConnectToNetwork(viewcontroller: UIViewController) -> Bool {
        var reachability:HYReachability?
        do {
            reachability = try HYReachability.reachabilityForInternetConnection()
        }
        catch{
            let alertController = UIAlertController(title: "温馨提示", message: "网络错误！", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            viewcontroller.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        if reachability!.isReachable(){
            return true
        }
        else {
            let alertController = UIAlertController(title: "温馨提示", message: "亲，您的网络连接未打开哦", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "前往打开", style: UIAlertActionStyle.Default, handler:{
                (action: UIAlertAction!) -> Void in
                //打开设置页面  注：未测试成功
                let url = NSURL(string: "prefs:root=WIFI")
                UIApplication.sharedApplication().openURL(url!)
            } )
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            viewcontroller.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
    }
    class func isWifiOpen() -> Bool {
        var reachability:HYReachability?
        do {
            reachability = try HYReachability.reachabilityForInternetConnection()
        }
        catch{
            return false
        }
        if reachability!.isReachableViaWiFi(){
            return true
        }
        else {
            return false
        }
    }
    class func getMacForWifiName(name:String) -> String? {
        if #available(iOS 9.0, *) {
           let networks = NEHotspotHelper.supportedNetworkInterfaces()
            for hotspot in networks {
                print("SSID:" + hotspot.SSID)
                print("MAC:" + hotspot.BSSID)
                print((hotspot as! NEHotspotNetwork).secure)
                print((hotspot as! NEHotspotNetwork).autoJoined)
                print((hotspot as! NEHotspotNetwork).signalStrength)
                if hotspot.SSID == name {
                    return hotspot.BSSID
                }
            }
        }
        else {
            if let cfa:NSArray = CNCopySupportedInterfaces() {
                for x in cfa {
                    if let dict = CFBridgingRetain(CNCopyCurrentNetworkInfo(x as! CFString)) {
                        let ssid = dict["SSID"]! as! String
                        let mac  = dict["BSSID"]! as! String
                        print("SSID:" + ssid)
                        print("MAC:" + mac)
                        if ssid == name {
                            return mac
                        }
                   }
               }
            }

        }
        return nil

    }

    
}