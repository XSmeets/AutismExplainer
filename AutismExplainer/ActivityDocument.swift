//
//  ActivityDocument.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 14/03/2025.
//

import SwiftUI
import UniformTypeIdentifiers

final class ActivityDocument: ReferenceFileDocument {
    typealias Snapshot = [Activity]
    
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
    
    init(data: Data) throws {
        self.activities = try JSONDecoder().decode([Activity].self, from: data)
    }

//    convenience init(url: URL) throws {
//        let configuration: ReadConfiguration = FileDocumentReadConfiguration(file: FileWrapper(url), contentType: .json))
//        try init(configuration: configuration)
//    }
    func snapshot(contentType: UTType) throws -> [Activity] {
        return self.activities
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(activities)
        return .init(regularFileWithContents: data)
    }
    
    func fileWrapper(snapshot: [Activity], configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(snapshot)
        return .init(regularFileWithContents: data)
    }
}
