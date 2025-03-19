//
//  ActivityDocument.swift
//  EnergyMeter
//
//  Created by Xander Smeets on 14/03/2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct ActivityDocument: FileDocument, Encodable, Decodable {
    static var readableContentTypes: [UTType] { [.json] }
    
    var activities: [Activity]
    var availableEnergy: Int = 10
    
    init(activities: [Activity] = [Activity(name: "", energyLevel: 1, color: .deterministicColor(0))], availableEnergy: Int = 10) {
        self.activities = activities
        self.availableEnergy = availableEnergy
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self = try JSONDecoder().decode(ActivityDocument.self, from: data)
    }
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(ActivityDocument.self, from: data)
    }

//    convenience init(url: URL) throws {
//        let configuration: ReadConfiguration = FileDocumentReadConfiguration(file: FileWrapper(url), contentType: .json))
//        try init(configuration: configuration)
//    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(self)
        return .init(regularFileWithContents: data)
    }
}
