//
//  BPtem+CoreDataProperties.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/13.
//
//

import Foundation
import CoreData
import SwiftUI

extension BPItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BPItem> {
        return NSFetchRequest<BPItem>(entityName: "BPtem")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var sbp: Int32
    @NSManaged public var dbp: Int32
    @NSManaged public var note: String
    
    func hypertenEnglish() -> String { // 用於決定狀態文字顏色
        var hyperText = ""
        if (sbp >= 140 && dbp >= 90) {
            hyperText = "Hypertension"
        }else if (sbp > 139 && sbp < 160 && dbp < 89 && dbp < 100) {
            hyperText = "Hypertension I"
        }else if(sbp > 159 && sbp < 180 || dbp > 99 && dbp < 110) {
            hyperText = "Hypertension II"
        }else if(sbp >= 180){
            hyperText = "Hypertension III"
        }else{
            hyperText = "Normal"
        }
        return(hyperText)
    }
    
    func hypertenChinese() -> String { // 用於決定狀態文字顏色
        var hyperText = ""
        if (sbp >= 140 && dbp >= 90) {
            hyperText = "高血壓"
        }else if (sbp > 139 && sbp < 160 && dbp < 89 && dbp < 100) {
            hyperText = "高血壓第一期"
        }else if(sbp > 159 && sbp < 180 || dbp > 99 && dbp < 110) {
            hyperText = "高血壓第二期"
        }else if(sbp >= 180){
            hyperText = "高血壓第三期"
        }else{
            hyperText = "正常"
        }
        return(hyperText)
    }
    
    func hypertenColor() -> Color { //用於決定數字顏色
        var hyperText = Color("")
        if (sbp >= 140 && dbp >= 90) {
            hyperText = Color.yellow
        }else if (sbp > 139 && sbp < 160 && dbp < 89 && dbp < 100) {
            hyperText = Color.orange
        }else if(sbp > 159 && sbp < 180 || dbp > 99 && dbp < 110){
            hyperText = Color.brown
        }else if(sbp >= 180){
            hyperText = Color.red
        }else{
            hyperText = Color.blue
        }
        return(hyperText)
    }
}

extension BPItem : Identifiable {

}
