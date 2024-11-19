//
//  choicesApp.swift
//  choices
//
//  Created by liuzehui on 2024/11/19.
//

import SwiftUI

@main
struct choicesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
