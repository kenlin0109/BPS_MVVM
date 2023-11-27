//
//  ContentView.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var vm: BPItemViewModel

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BPItem.timestamp!, ascending: true)],
        animation: .default)
    private var items: FetchedResults<BPItem>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        DetailPageView(item: item)
                    } label: {
                        Text("\(item.timestamp ?? Date(), formatter: itemFormatter)     \(item.sbp)     \(item.dbp)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: NewItemView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            vm.save(viewContext)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
