//
//  ToolsView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 14/03/2025.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

struct ToolsView: View {
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        NavigationStack {
            VStack {
                Text("This app provides several tools for people with autism.")
                ScrollView {
                    NavigationLink(destination: EmotionCircleView()) {
                        Text("Emotion circle")
                    }
//                    NewDocumentButton("Energy Meter", for: ActivityDocument.self)
#if os(macOS)
                    Button("Energy Meter") {
                        NSDocumentController.shared.newDocument(nil)
                        #if os(iOS)
//                        let fileManager = FileManager.default
//                        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//                        let fileURL = documentsDirectory.appendingPathComponent("activities.json")
////                        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("activities.json")
//                        // Create and save an empty document
//                        let document = ActivityDocument()
//                        do {
//                            let data = try JSONEncoder().encode(document.activities)
//                            try data.write(to: fileURL, options: .atomic)
//                            // Open the document using the UIDocumentPicker
////                            DispatchQueue.main.async {
//                                UIApplication.shared.open(fileURL)
////                            }
//                            // DispatchQueue.main.async {
//                            //     let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.json])
//                            //     picker.delegate = DocumentPickerDelegate.shared
//                            //     UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
//                            // }
//                        } catch {
//                            print("Failed to create document: \(error)")
//                        }
                        #endif
                    }
#endif
                    #if os(iOS)
                    NavigationLink("Energy Meter", destination: DocumentLaunchView(for: [.json]) {
                        NewDocumentButton("New Energy Schema")
                    } onDocumentOpen: { url in
                        EnergyMeterView(url)
                    })
                    #endif
                    // NavigationLink(destination: EnergyMeterView(document: ActivityDocument())) {
                        // Text("Energy Meter")
                    // }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .navigationTitle("Tools")
    }
}

private func getDocumentContents(for url: URL) -> ActivityDocument {
    do {
//        let fileWrapper = try FileWrapper(url: url, options: .immediate)
//        let configuration = ActivityDocument.ReadConfiguration(file: fileWrapper)
//        _ = try ActivityDocument(configuration: configuration)
        let data = try Data(contentsOf: url)
        return try ActivityDocument(data: data)
    } catch {
        print("Failed to open document: \(error)")
        return ActivityDocument()
    }
}
#if os(iOS)
// Handle opening document via UIDocumentPicker (iOS only)
class DocumentPickerDelegate: NSObject, UIDocumentPickerDelegate {
    static let shared = DocumentPickerDelegate()
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("Selected document: \(urls.first?.absoluteString ?? "None")")
    }
}
#endif

#Preview {
    ToolsView()
    .environment(\.locale, .init(identifier: "nl"))
}
