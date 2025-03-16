//
//  Activity.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 14/03/2025.
//
import SwiftUICore

@Observable
final class Activity: Identifiable, Codable {
    let id: UUID
    var name: String
    var energyLevel: Int
    var color: Color
    
    enum CodingKeys: String, CodingKey {
        case id, name, energyLevel, color
        case red, green, blue, opacity
    }
    
    init(name: String, energyLevel: Int, color: Color) {
        self.id = UUID()
        self.name = name
        self.energyLevel = energyLevel
        self.color = color
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        energyLevel = try container.decode(Int.self, forKey: .energyLevel)
        let red = try container.decode(Double.self, forKey: .red)
        let green = try container.decode(Double.self, forKey: .green)
        let blue = try container.decode(Double.self, forKey: .blue)
        let opacity = try container.decode(Double.self, forKey: .opacity)
        color = Color(red: red, green: green, blue: blue, opacity: opacity)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(energyLevel, forKey: .energyLevel)
        
        let components = color.cgColor?.components ?? [0, 0, 0, 1]
        try container.encode(components[0], forKey: .red)
        try container.encode(components[1], forKey: .green)
        try container.encode(components[2], forKey: .blue)
        try container.encode(components[3], forKey: .opacity)
    }
}

extension Color {
    static func deterministicColor(_ index: Int) -> Color {
        let hash = abs(index.hashValue)
        let hue = Double(hash % 360) / 360.0
        let saturation: Double = 0.7
        let lightness: Double = 0.5
        
        return Color(hue: hue, saturation: saturation, brightness: lightness)
    }
}
