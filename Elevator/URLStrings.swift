//
//  URLStrings.swift
//  Elevator
//
//  Created by 郝赟 on 16/5/18.
//  Copyright © 2016年 haoyun. All rights reserved.
//
var baseURLString:String = {
    if let domain = HYDefaults[.applicationAddress], let port = HYDefaults[.applicationPort] {
        return "http://" + domain + ":" + port + "/twoCodemobileweb/sjba/"
    }
    return "http://cddt.zytx-robot.com/twoCodemobileweb/sjba/"
}()
struct URLStrings {
    static var queryRegistNmuberByMac = baseURLString + "queryRegistNumberByMac.do"
    static var queryEleInfoMobile1 = baseURLString + "queryEleInfoMobile1.do"
    static var queryEleInfoMobile = baseURLString + "queryEleInfoMobile.do"
    static var tcIsValidMobile = baseURLString + "tcIsValidMobile.do"
    static var remarkListMobile = baseURLString + "remarkListMobile.do"
    static var remarkAddMobile = baseURLString + "remarkAddMobile.do"
    static var querymacEleInfoMobile1 = baseURLString + "querymacEleInfoMobile1.do"
    static var querymacEleInfoMobile = baseURLString + "querymacEleInfoMobile.do"
}
