//
//  EnergyMeterApp.swift
//  EnergyMeter
//
//  Created by Xander Smeets on 16/03/2025.
//

import SwiftUI

@main
struct EnergyMeterApp: App {
    var body: some Scene {
        #if os(iOS)
        DocumentGroupLaunchScene("Energy Meter") {
            let _ = debugPrint("iOS detected: Launch scene probably supported")
            NewDocumentButton("Create Energy Scheme", for: ActivityDocument.self)
        }
        #elseif os(visionOS)
        WindowGroup(id: "main") {
            VisionOSCustomStartScreen()
        }
        .windowStyle(.plain) // Prevents system overrides

        WindowGroup(id: "newDocument") {
            EnergyMeterView(document: .constant(ActivityDocument()))
        }
        #endif
        DocumentGroup(newDocument: ActivityDocument()) { file in
            EnergyMeterView(document: file.$document)
        }
    }
}

struct VisionOSCustomStartScreen: View {
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        VStack {
            Button("Create New Document") {
                openWindow(id: "newDocument")
            }
            Button("Open Document") {
                openWindow(id: "documentPicker")
            }
        }
        .padding()
    }
}

#Preview {
    EnergyMeterView(document: .constant(ActivityDocument()))
    .environment(\.locale, .init(identifier: "nl"))
}
