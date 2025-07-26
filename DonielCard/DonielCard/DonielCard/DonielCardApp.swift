//
//  DonielCardApp.swift
//  DonielCard
//
//  Created by Doniel Tripura on 26/7/25.
//

import SwiftUI

@main
struct DonielCardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
