//
//  EnergyMeterView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    var name: String
    var energyLevel: Int
    var color: Color
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
                
                // Save button
                Button(action: saveActivities) {
                    Text("Save Activities")
                }
                .padding()
            }
        }
    }

    func saveActivities() {
        // Implement saving to iCloud Drive or CloudKit here
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
