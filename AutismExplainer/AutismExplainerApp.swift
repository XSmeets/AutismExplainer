//
//  AutismExplainerApp.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

@main
struct AutismExplainerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .commands {
//            CommandGroup(replacing: .newItem) {
//                Button(action: {
//                    let newDocument = ActivityDocument()
//                    let url = FileManager.default.temporaryDirectory.appendingPathComponent("NewActivities.json")
//                    do {
//                        let data = try JSONEncoder().encode(newDocument.activities)
//                        try data.write(to: url)
//                        #if os(macOS)
//                        NSDocumentController.shared.openDocument(withContentsOf: url, display: true, completionHandler: { _, _, _ in })
//                        #else
//                        // For iOS, use DocumentGroup to open the document
//                        UIApplication.shared.open(url)
//                        #endif
//                    } catch {
//                        print("Failed to create new document: \(error.localizedDescription)")
//                    }
//                }) {
//                    Text("New Activity Document")
//                }
//                .keyboardShortcut("N", modifiers: [.command])
//            }
//        }
        DocumentGroup(newDocument: ActivityDocument()) { file in
            EnergyMeterView(document: file.document)
        }
    }
}
