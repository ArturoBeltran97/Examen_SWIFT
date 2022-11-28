//
//  ExamenSWIFTApp.swift
//  ExamenSWIFT
//
//  Created by CCDM08 on 24/11/22.
//

import SwiftUI

@main
struct ExamenSWIFTApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
