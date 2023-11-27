//
//  NewItemView.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/13.
//

import SwiftUI
import CoreData

struct NewItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var vm: BPItemViewModel
    
    var body: some View {
        List {
            DatePicker(
                    "量測日期",
                    selection: $vm.timestamp,
                    displayedComponents: [.date]
                )
            Picker("收縮壓", selection: $vm.sbp) {
                ForEach(50..<300) { i in
                    Text("\(i)").tag(i)
                }
            }
            
            Picker("舒張壓", selection: $vm.dbp) {
                ForEach(50..<300) { i in
                    Text("\(i)").tag(i)
                }
            }
            
            Button {
                vm.createBPItem(viewContext)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Label("save",
                      systemImage: "plus.circle.fill")}
        }
    }
}

let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.zeroSymbol = ""
    return formatter
}()
