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
        #if !os(macOS)
        DocumentGroupLaunchScene("Energy Meter") {
            NewDocumentButton("Create Energy Scheme", for: ActivityDocument.self)
        }
        #endif
        DocumentGroup(newDocument: { ActivityDocument() }) { file in
            // `file` is a ReferenceFileDocumentConfiguration<ActivityDocument>
            EnergyMeterView(document: file.$document)
        }
    }
}

//#Preview {
//    EnergyMeterView(document: ActivityDocument())
//    .environment(\.locale, .init(identifier: "nl"))
//}
