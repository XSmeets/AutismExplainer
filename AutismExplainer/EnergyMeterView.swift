//
//  EnergyMeterView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI
#if os(macOS)
import AppKit
#endif

struct EnergyMeterView: View {
    @ObservedObject var document: ActivityDocument
    @State private var availableEnergy: Int = 10
    @State private var documentURL: URL? = nil
    @State private var showingPicker: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                // Energy usage overview
                VStack {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            ForEach(document.activities, id: \.id) { activity in
                                Rectangle()
                                    .fill(activity.color)
                                    .frame(width: CGFloat(activity.energyLevel) / CGFloat(availableEnergy) * geometry.size.width)
                                    .overlay(
                                        Text(activity.name)
                                            .foregroundColor(.white)
                                            .padding(4)
                                    )
                            }
                        }
                    }
                    .frame(height: 50)
                }
                .padding()
                
                // Activities input
                ForEach(document.activities.indices, id: \.self) { index in
                    HStack {
                        TextField("Activity", text: $document.activities[index].name)
                            .padding(4)
                            .background(document.activities[index].color.opacity(0.3))
                            .cornerRadius(4)
                        #if os(tvOS)
                            TextField("Energy Level", value: $document.activities[index].energyLevel, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .padding(4)
                                .background(document.activities[index].color.opacity(0.3))
                                .cornerRadius(4)
                        #else
                            Stepper(value: $document.activities[index].energyLevel, in: 1...maxEnergyLevel(for: index)) {
                                Text("\(document.activities[index].energyLevel)")
                                    .padding(4)
                                    .background(document.activities[index].color.opacity(0.3))
                                    .cornerRadius(4)
                            }
                        #endif
                    }
                    .padding(.horizontal)
                }
                
                // Add new activity button
                Button(action: {
                    let newIndex = document.activities.count
                    document.activities.append(Activity(name: "", energyLevel: 1, color: .deterministicColor(newIndex)))
                }) {
                    Text("Add Activity")
                }
                .padding()
                .disabled(totalEnergyUsed() >= availableEnergy)

                // Document Picker Section
                #if os(macOS)
                Button("Open Document") {
                    let panel = NSOpenPanel()
                    panel.allowedContentTypes = ActivityDocument.readableContentTypes
                    panel.allowsMultipleSelection = false
                    if panel.runModal() == .OK {
                        documentURL = panel.url
                    }
                }
                .padding()
                #else
                Button(action: {
                    showingPicker = true
                }) {
                    Text("Open Document")
                }
                .padding()
                
                .sheet(isPresented: $showingPicker) {
                    DocumentPicker(documentURL: $documentURL)
                }
                #endif

                if let url = documentURL {
                    // Load document into object
                    var document_temp: ActivityDocument = try! ActivityDocument(url: url)
                    // Overwrite object with new document
                    document.activities = document_temp.activities
                }
            }
        }
    }

    private func maxEnergyLevel(for index: Int) -> Int {
        let totalEnergyUsed = document.activities.reduce(0) { $0 + $1.energyLevel }
        let remainingEnergy = availableEnergy - (totalEnergyUsed - document.activities[index].energyLevel)
        return remainingEnergy
    }

    private func totalEnergyUsed() -> Int {
        return document.activities.reduce(0) { $0 + $1.energyLevel }
    }
}

#Preview {
   EnergyMeterView(document: ActivityDocument())
}

#if os(iOS)
import UIKit

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var documentURL: URL?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.documentURL = urls.first
        }
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: ActivityDocument.readableContentTypes)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}
#endif
