//
//  ExamenLomeliCrudApp.swift
//  ExamenLomeliCrud
//
//  Created by CCDM29 on 14/11/22.
//

import SwiftUI
@main

struct ExamenLomeliCrudApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
