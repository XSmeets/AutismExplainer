//
//  ActivityDocument.swift
//  EnergyMeter
//
//  Created by Xander Smeets on 14/03/2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct ActivityDocument: FileDocument, Encodable, Decodable {
    static var readableContentTypes: [UTType] { [.activityDocument] }
    
    var activities: [Activity]
    var availableEnergy: Int = 10
    var maximumEnergy: Int = 10
    
    init(activities: [Activity] = [Activity(name: "", energyLevel: 1, color: .deterministicColor(0))], availableEnergy: Int = 10, maximumEnergy: Int = 10) {
        self.activities = activities
        self.availableEnergy = availableEnergy
        self.maximumEnergy = maximumEnergy
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

    // Custom Decodable initializer to handle missing maximumEnergy
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.activities = try container.decode([Activity].self, forKey: .activities)
        self.availableEnergy = try container.decodeIfPresent(Int.self, forKey: .availableEnergy) ?? 10
        self.maximumEnergy = try container.decodeIfPresent(Int.self, forKey: .maximumEnergy) ?? self.availableEnergy
    }

//    convenience init(url: URL) throws {
//        let configuration: ReadConfiguration = FileDocumentReadConfiguration(file: FileWrapper(url), contentType: .activityDocument))
//        try init(configuration: configuration)
//    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(self)
        return .init(regularFileWithContents: data)
    }

    enum CodingKeys: String, CodingKey {
        case activities
        case availableEnergy
        case maximumEnergy
    }
}
