//
//  ChartPageView.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/21.
//

import SwiftUI
import CoreData
import Foundation
import Charts

struct bpinfo {
    public var mdate: Date
    public var sbp: Int
    public var dbp: Int
}

struct ChartPageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var theme = Theme.shared
    
    let startDate = Calendar.current.date(byAdding: .day, value: -140, to: Date())
    
    private var request = FetchRequest<BPItem>(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPItem.timestamp, ascending: false)],
        animation: .default
    )
    
    private var items: FetchedResults<BPItem>{
        print("begin items --> FetchResults")
        request.wrappedValue.nsPredicate = NSPredicate(format: "(timestamp >= %@)", startDate! as CVarArg)
        print("end items --> FetchResults")
        return request.wrappedValue
    }
    
    @State var bpdict = [String: bpinfo]()
    @State var bpdarr = [String]()
    @State var mindbp: Int32 = 120
    @State var maxsbp: Int32 = 0
    
    var body: some View {
        NavigationView {
            VStack{
                Chart {
                    ForEach(Array(bpdarr.enumerated()), id: \.offset ) {index, key in
                        LineMark(
                            x: .value("date", index),
                            y: .value("sbp", bpdict[key]?.sbp ?? 0)
                        )
                        .foregroundStyle(by: .value("Type", "\(theme.isZhorEn ? "SBP" : "收縮壓")"))
                        
                        LineMark(
                            x: .value("date", index),
                            y: .value("dbp", bpdict[key]?.dbp ?? 0)
                        )
                        .foregroundStyle(by: .value("Type", "\(theme.isZhorEn ? "DBP" : "舒縮壓")"))
                        
                        LineMark(
                            x: .value("date", index),
                            y: .value("sbp", 120)
                        )
                        .foregroundStyle(by: .value("Type", "\(theme.isZhorEn ? "Standard SBP" : "標準收縮壓")"))
                        
                        LineMark(
                            x: .value("date", index),
                            y: .value("dbp", 80)
                        )
                        .foregroundStyle(by: .value("Type", "\(theme.isZhorEn ? "Standard DBP" : "標準舒縮壓")"))
                        
                        PointMark(
                            x: .value("date", index),
                            y: .value("sbp", bpdict[key]?.sbp ?? 0)
                        )
                        .annotation {
                            Text("\(bpdict[key]?.sbp ?? 0)")  //  \(bpdict[key]?.mdate ?? Date(), formatter: MMddFormatter)
                        }
                        
                        PointMark(
                            x: .value("date", index),
                            y: .value("dbp", bpdict[key]?.dbp ?? 0)
                        )
                        .annotation {
                            Text("\(bpdict[key]?.dbp ?? 0)")  //  \(bpdict[key]?.mdate ?? Date(), formatter: MMddFormatter)
                        }
                    }
                }
                .padding(25)
                .chartYScale(domain: [mindbp-10, maxsbp+10])
                .chartXAxis {
                    AxisMarks(values: .stride(by: 1)) { value in
                        AxisGridLine()
                        AxisValueLabel{
                            if let localIndex = value.as(Int.self) {
                                if localIndex>=0 && localIndex<bpdarr.count {
                                    let dateStr = bpdarr[localIndex].suffix(5)
                                    Text(dateStr)
                                        .font(.system(size: 12))
                                        .rotationEffect(Angle(degrees: 25))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(theme.isZhorEn ? "Statistics" : "統計")
        }
        .onAppear {
            filterdata()
            bpdarr = bpdict.keys.sorted(by: <)
        }
    }
    func filterdata() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let mindate = Calendar.current.date(byAdding: .day, value: -140, to: Date())
            //let today = Date()
        
        let items2=items.filter{ $0.timestamp! > mindate! }
        
        
        for item in items2 {
            //if item.mdate!>mindate! && item.mdate!<today {
            
            let mdate = formatter.string(from: item.timestamp!)
            let sbp = item.sbp
            let dbp = item.dbp
            
            if dbp < mindbp { mindbp = Int32(dbp) }
            if sbp > maxsbp { maxsbp = Int32(sbp) }
            
            if let oldData = bpdict[mdate] {
                let oldSBP = oldData.sbp
                let oldDBP = oldData.dbp
                bpdict[mdate] = bpinfo(mdate: item.timestamp!, sbp: (oldSBP+Int(sbp))/2, dbp: (oldDBP+Int(dbp))/2)
            } else {
                bpdict[mdate] = bpinfo(mdate: item.timestamp!, sbp: Int(sbp), dbp: Int(dbp))
            }
        }
        if mindbp==120 { mindbp = 50 }
        if maxsbp==0 { maxsbp = 120 }
    }
}

let MMddFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd"
    return formatter
}()
