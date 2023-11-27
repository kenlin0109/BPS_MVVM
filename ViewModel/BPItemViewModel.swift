//
//  BPItemViewModel.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/13.
//

import Foundation
import CoreData
import Combine

class BPItemViewModel: ObservableObject {
    @Published var timestamp = Date()
    @Published var sbp: Int = 50
    @Published var dbp: Int = 50
    @Published var note: String = ""
    
    @Published var bpItem: BPItem!
    
    func createBPItem(_ context: NSManagedObjectContext) {
        if bpItem == nil {
            let tmpBPItem = BPItem(context: context)
            tmpBPItem.timestamp = timestamp
            tmpBPItem.sbp = Int32(sbp)
            tmpBPItem.dbp = Int32(dbp)
            tmpBPItem.note = String(note)
        } else {
            bpItem.timestamp = timestamp
            bpItem.sbp = Int32(sbp)
            bpItem.dbp = Int32(dbp)
            bpItem.note = String(note)
        }
        save(context)
    }
    
    func save(_ context: NSManagedObjectContext){
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    func setDefaultValue(item: BPItem) {
        timestamp = item.timestamp ?? Date()
        sbp = Int(item.sbp)
        dbp = Int(item.dbp)
        note = item.note
    }
    
    func edit(_ context: NSManagedObjectContext, item: BPItem){
        item.timestamp = timestamp
        item.sbp = Int32(sbp)
        item.dbp = Int32(dbp)
        item.note = String(note)
        
        save(context)
    }
}


