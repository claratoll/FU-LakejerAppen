//
//  LakerslakejerApp.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-11.
//

import SwiftUI

@main
struct LakerslakejerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
