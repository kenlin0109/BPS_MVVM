//
//  ReadView.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/14.
//

import SwiftUI

struct ReadView: View {
    @State var item: BPItem
    //@StateObject var theme = Theme.shared
    
    
    var body: some View {
        VStack{
            List{
                MessurementTime(title: Theme.shared.isZhorEn ? "Measurement time" : "量測時間", date: item.timestamp!)
                BloodPresureInfo()
                ShowStatus()
                ShowNote()
            }
        }
    }
    
    @ViewBuilder
    func MessurementTime(title: String, date: Date) -> some View {
        HStack{
            Text(title)
                .frame(width: 75, alignment: .leading)
            Text("\(date, formatter: itemFormatter)")
        }
    }
    
    @ViewBuilder
    func BloodPresureInfo() -> some View {
        HStack{
            Text(Theme.shared.isZhorEn ? "SBP" : "收縮壓")
                .frame(width: 75, alignment: .leading)
            Text("\(item.sbp)")
                .foregroundColor(Const.GetSBPFontColor(Int(item.sbp)))
        }
        HStack{
            Text(Theme.shared.isZhorEn ? "DBP" : "舒張壓")
                .frame(width: 75, alignment: .leading)
            Text("\(item.dbp)")
                .foregroundColor(Const.GetDBPFontColor(Int(item.dbp)))
        }
    }
    
    @ViewBuilder
    func ShowStatus() -> some View {
        HStack{
            Text(Theme.shared.isZhorEn ? "Body condition" : "狀態")
                .frame(width: 75, alignment: .leading)
            Text("\(Theme.shared.isZhorEn ? item.hypertenEnglish() : item.hypertenChinese())")
                .foregroundColor(item.hypertenColor())
        }
    }
    
    @ViewBuilder
    func ShowNote() -> some View {
        HStack{
            Text(Theme.shared.isZhorEn ? "Note" : "備註")
                .frame(width: 75, alignment: .leading)
            Text("\(item.note)")
        }
    }
}




