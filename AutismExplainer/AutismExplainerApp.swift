//
//  AutismExplainerApp.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

@main
struct AutismExplainerApp: App {
    #if false /*os(iOS)*/
    @State private var documentScene: DocumentGroupLaunchScene<ActivityDocument>? = nil
    #endif
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
        #if os(iOS) || os(visionOS)
        DocumentGroupLaunchScene("Energy Meter") {
            NewDocumentButton("Create Energy Scheme", for: ActivityDocument.self)
        }
//        .bind($documentScene) // Bind the scene to allow external control
        #endif
        DocumentGroup(newDocument: ActivityDocument()) { file in
            EnergyMeterView(document: file.document)
        }
    }
}

#Preview {
    ContentView()
    .environment(\.locale, .init(identifier: "nl"))
}
