//
//  ManageSheetsApp.swift
//  Shared
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI
import CoreData

@main
struct ManageSheetsApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
