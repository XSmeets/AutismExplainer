//
//  EnergyMeterView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct Activity: Identifiable, Codable {
    let id: UUID
    var name: String
    var energyLevel: Int
    var color: Color
    
    enum CodingKeys: String, CodingKey {
        case id, name, energyLevel, color
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
        let colorData = try container.decode(Data.self, forKey: .color)
        // EnergyMeterView.swift:33:39 'unarchiveTopLevelObjectWithData' was deprecated in macOS 10.14: Use unarchivedObject(ofClass:from:) instead
        if let nsColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: colorData) {
            color = Color(nsColor)
        } else {
            color = .black
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(energyLevel, forKey: .energyLevel)
        let colorData = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        try container.encode(colorData, forKey: .color)
    }
}

struct EnergyMeterView: View {
    @State private var activities: [Activity] = [Activity(name: "", energyLevel: 1, color: .deterministicColor(0))]
    @State private var availableEnergy: Int = 10
    
    var body: some View {
        ScrollView {
            VStack {
                // Energy usage overview
                VStack {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            ForEach(activities, id: \.id) { activity in
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
                ForEach(activities.indices, id: \.self) { index in
                    HStack {
                        TextField("Activity", text: $activities[index].name)
                            .padding(4)
                            .background(activities[index].color.opacity(0.3))
                            .cornerRadius(4)
                            // .onChange(of: activities[index].name) {
                            //     if index == activities.count - 1 && !activities[index].name.isEmpty {
                            //         activities.append(Activity(name: "", energyLevel: 1, color: .deterministicColor(activities.count)))
                            //     }
                            // }
                        Stepper(value: $activities[index].energyLevel, in: 1...maxEnergyLevel(for: index)) {
                            Text("\(activities[index].energyLevel)")
                                .padding(4)
                                .background(activities[index].color.opacity(0.3))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Add new activity button
                Button(action: {
                    let newIndex = activities.count
                    activities.append(Activity(name: "", energyLevel: 1, color: .deterministicColor(newIndex)))
                }) {
                    Text("Add Activity")
                }
                .padding()
                .disabled(totalEnergyUsed() >= availableEnergy)
                
                HStack {
                    // Load button
                    Button(action: loadActivities) {
                        Text("Load Activities")
                    }
                    .padding()

                    // Save button
                    Button(action: saveActivities) {
                        Text("Save Activities")
                    }
                    .padding()
                }
            }
        }
    }

    func saveActivities() {
        #if os(iOS) || os(visionOS)
        let documentPicker = UIDocumentPickerViewController(forExporting: [URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("activities.json")])
        documentPicker.delegate = context.coordinator
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
        #elseif os(macOS)
        let panel = NSSavePanel()
        panel.allowedContentTypes = [.json]
        panel.nameFieldStringValue = "activities.json"
        
        panel.begin { response in
            if response == .OK, let url = panel.url {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                do {
                    let data = try encoder.encode(activities)
                    try data.write(to: url)
                    print("Activities saved to \(url).")
                } catch {
                    print("Failed to save activities: \(error.localizedDescription)")
                }
            }
        }
        #endif
    }
    
    func loadActivities() {
        #if os(iOS) || os(visionOS)
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.json])
        documentPicker.delegate = context.coordinator
        UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
        #elseif os(macOS)
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.json]
        panel.allowsMultipleSelection = false
        
        panel.begin { response in
            if response == .OK, let url = panel.url {
                let decoder = JSONDecoder()
                
                do {
                    let data = try Data(contentsOf: url)
                    activities = try decoder.decode([Activity].self, from: data)
                    print("Activities loaded from \(url).")
                } catch {
                    print("Failed to load activities: \(error.localizedDescription)")
                }
            }
        }
        #endif
    }

    private func maxEnergyLevel(for index: Int) -> Int {
        let totalEnergyUsed = activities.reduce(0) { $0 + $1.energyLevel }
        let remainingEnergy = availableEnergy - (totalEnergyUsed - activities[index].energyLevel)
        return remainingEnergy
    }

    private func totalEnergyUsed() -> Int {
        return activities.reduce(0) { $0 + $1.energyLevel }
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

#Preview {
    EnergyMeterView()
}
