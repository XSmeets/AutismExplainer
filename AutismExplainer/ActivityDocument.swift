//
//  ActivityDocument.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 14/03/2025.
//

import SwiftUI
import UniformTypeIdentifiers

final class ActivityDocument: ObservableObject, FileDocument {
    static var readableContentTypes: [UTType] { [.json] }
    
    @Published var activities: [Activity]
    
    init(activities: [Activity] = [Activity(name: "", energyLevel: 1, color: .deterministicColor(0))]) {
        self.activities = activities
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.activities = try JSONDecoder().decode([Activity].self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(activities)
        return .init(regularFileWithContents: data)
    }
}
