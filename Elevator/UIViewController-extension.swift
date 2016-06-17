//
//  UIViewController-extension.swift
//  Elevator
//
//  Created by 郝赟 on 16/6/17.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
extension UIViewController{
    class func getCurruntVC()->UIViewController{
        var resultVC:UIViewController?
        var window = UIApplication.sharedApplication().keyWindow!
        if (window.windowLevel != UIWindowLevelNormal)
        {
            let windows = UIApplication.sharedApplication().windows
            for tempWindow in windows {
                if tempWindow.windowLevel == UIWindowLevelNormal {
                    window = tempWindow
                    break
                }
            }
            let frontView = window.subviews[0]
            let nextResponder = frontView.nextResponder()
            if nextResponder!.isKindOfClass(UIViewController) {
                resultVC = nextResponder as? UIViewController
            }
        }
        else {
            resultVC = window.rootViewController
        }
        return resultVC!
    }
}