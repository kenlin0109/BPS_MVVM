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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
