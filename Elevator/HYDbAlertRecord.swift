//
//  HYDbAlertRecord.swift
//  Elevator
//
//  Created by 郝赟 on 16/6/17.
//  Copyright © 2016年 haoyun. All rights reserved.
//

import Foundation
import SQLite
class HYDbAlertRecord:NSObject {
    let db = try! Connection(Constants.dbPath)
    let alertRecordTable = Table("alertRecord")
    let id = Expression<Int>("id")
    let twoCodeId = Expression<String>("twoCodeId")  //URL
    let address = Expression<String>("address")
    let imgName = Expression<String>("imgName")
    let date = Expression<String>("date")
    //创建查询记录表
    override init() {
        super.init()
        self.createAlertRecordTable()
    }
    func createAlertRecordTable() {
        try! db.run(alertRecordTable.create(ifNotExists: true){ t in
            t.column(id, primaryKey: .Autoincrement)
            t.column(twoCodeId, unique: true)
            t.column(address)
            t.column(imgName)
            t.column(date)
            })
    }
    //查询
    func getAllAlertRecord() -> [AlertRecord] {
        return convertToArray(db.prepare(alertRecordTable))
    }
    func getAlertRecordForAddress(addressString:String) -> [AlertRecord]  {
        let query = alertRecordTable.select(*).filter(address.like("%\(addressString)%")).order(id.desc)
        return convertToArray(db.prepare(query))
    }
    func getAlertRecordForTwoCodeId(twoCodeIdStr:String) -> [AlertRecord]{
        let query = alertRecordTable.select(*).filter(twoCodeId == twoCodeIdStr).order(id.desc)
        return convertToArray(db.prepare(query))
    }
    //插入
    func insert(object:AlertRecord)-> Bool {
        do {
            try db.run(alertRecordTable.insert(twoCodeId <- object.twoCodeId,address <- object.address,imgName <- object.imgName,date <- object.date))
            return true
        } catch {
            return false
        }
    }
    //删除
    func deleteRow(rowId:Int)-> Bool {
        do {
            let row = alertRecordTable.filter(id == rowId)
            try db.run(row.delete())
            return true
        } catch {
            return false
        }
    }
    //更新
    func update(object:AlertRecord)-> Bool {
        if getAlertRecordForTwoCodeId(object.twoCodeId).count > 0 {
            do {
                let row = alertRecordTable.filter(twoCodeId == object.twoCodeId)
                try db.run(row.update(twoCodeId <- object.twoCodeId,address <- object.address,imgName <- object.imgName,date <- object.date))
                return true
            } catch {
                return false
            }
            
        }
        else {
            return insert(object)
        }
    }
    func convertToArray(rows:AnySequence<Row>) -> [AlertRecord]{
        var alertRecordArray = Array<AlertRecord>()
        for row in rows {
            let alertRecord = AlertRecord()
            alertRecord.id = row[id]
            alertRecord.address = row[address]
            alertRecord.twoCodeId = row[twoCodeId]
            alertRecord.date = row[date]
            alertRecord.imgName = row[imgName]
            alertRecordArray.append(alertRecord)
        }
        return alertRecordArray
    }
    
    
}

