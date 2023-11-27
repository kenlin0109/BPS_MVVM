//
//  DetailPageView.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/14.
//

import SwiftUI

struct DetailPageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var vm: BPItemViewModel
    @StateObject var theme = Theme.shared
    @ObservedObject var item: BPItem
    
    @State var isReadMode: Bool = true
    
    var body: some View {
        VStack {
            if isReadMode {
                ReadView(item: item)
                
            } else {
                List {
                    DatePicker(selection: $vm.timestamp, label: { Text(theme.isZhorEn ? "Measurement time" : "量測時間") })
                    
                    Picker(theme.isZhorEn ? "SBP" : "收縮壓", selection: $vm.sbp,content:  {
                        ForEach(Const.SBPMin ..< Const.SBPMax) { n in
                            Text("\(n)").tag(n)
                        }
                    })
                    
                    Picker(theme.isZhorEn ? "DBP" : "舒張壓", selection: $vm.dbp,content:  {
                        ForEach(Const.DBPMin ..< Const.DBPMax) { n in
                            Text("\(n)").tag(n)
                        }
                    })
                    
                    Text(theme.isZhorEn ? "Note" : "備註")
                    TextField("\(item.note)", text: $vm.note)
                        .textFieldStyle(.roundedBorder)
                        .border(.black, width: 1)
                }
                .onAppear {
                    print("onAppear")
                    //進入頁面時將預設數值填入
                    vm.setDefaultValue(item: item)
                }
            }
        }
        .toolbar {
            Button{
                if !isReadMode {
                    vm.edit(viewContext, item: item)
                }
                isReadMode = !isReadMode
            } label: {
                Text(isReadMode ? (theme.isZhorEn ? "Edit" : "編輯" ) : (theme.isZhorEn ? "Save" : "儲存"))
            }
        }
    }
}


