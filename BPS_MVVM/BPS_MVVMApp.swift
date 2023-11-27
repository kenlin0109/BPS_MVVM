//
//  BPS_MVVMApp.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/13.
//

import SwiftUI

@main

struct BPS_MVVMApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var bpItemViewModel = BPItemViewModel()
    @StateObject var theme = Theme.shared
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(bpItemViewModel)
                //.environmentObject(theme)
        }
    }
}
