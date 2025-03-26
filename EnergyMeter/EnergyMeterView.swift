//
//  EnergyMeterView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct EnergyMeterView: View {
    @Binding var document: ActivityDocument
    
    var body: some View {
            VStack {
                // Energy usage overview
                VStack {
                    GeometryReader { geometry in
                        ZStack {
                            // Background bar
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.3)) // Light gray for contrast
                                .frame(width: geometry.size.width, height: 50)
                            
                            // Overflow energy bar
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.red.opacity(0.3)) // Red for 'overflow' energy'
                                .frame(
                                    width: document.maximumEnergy > 0
                                        ? max(0, CGFloat(document.maximumEnergy - document.availableEnergy) / CGFloat(document.maximumEnergy) * geometry.size.width)
                                        : 0, // Ensure width is 0 if maximumEnergy is 0
                                    height: 50
                                )
                                .position(x: geometry.size.width - (document.maximumEnergy > 0
                                    ? max(0, CGFloat(document.maximumEnergy - document.availableEnergy) / CGFloat(document.maximumEnergy) * geometry.size.width) / 2
                                    : 0), y: 25) // Align to the trailing edge

                            // Energy levels
                            HStack(spacing: 0) {
                                ForEach(document.activities, id: \.id) { activity in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(activity.color)
                                        .frame(width: CGFloat(activity.energyLevel) / CGFloat(document.maximumEnergy) * geometry.size.width)
                                        .overlay(
                                            Text(activity.name)
                                                .foregroundColor(.white)
                                                .padding(4)
                                        )
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .frame(height: 50)
                }
                .padding()
                
                HStack {
                    #if os(macOS)
                    HStack {
                        // Field for modifying available energy
                        Stepper(value: $document.availableEnergy, in: 1...document.maximumEnergy) {
                            Text("Available Energy: \(document.availableEnergy)")
                        }
                        .padding(.horizontal)
                        
                        // Field for modifying maximum energy
                        Stepper(value: $document.maximumEnergy, in: document.availableEnergy...100) {
                            Text("Maximum Energy: \(document.maximumEnergy)")
                        }
                        .padding(.horizontal)
                    }
                    #elseif os(iOS)
                    VStack {

                        // Field for modifying available energy
                        Stepper(value: $document.availableEnergy, in: totalEnergyUsed()...document.maximumEnergy) {
                            Text("Available Energy: \(document.availableEnergy)")
                        }
                        .padding(.horizontal)
                        
                        // Field for modifying maximum energy
                        Stepper(value: $document.maximumEnergy, in: document.availableEnergy...100) {
                            Text("Maximum Energy: \(document.maximumEnergy)")
                        }
                        .padding(.horizontal)
                    }
                    #endif
                    
                    Spacer()
                    
                    // Add new activity button
                    Button(action: {
                        let newIndex = document.activities.count
                        document.activities.append(Activity(name: "", energyLevel: 1, color: .deterministicColor(newIndex)))
                    }) {
                        Text("Add Activity")
                    }
                    .padding(.horizontal)
                    .disabled(totalEnergyUsed() >= document.maximumEnergy)
                }
                
                ScrollView {
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
                        // Color picker
                        ColorPicker(selection: $document.activities[index].color) {
                            Label("Color", systemImage: "eyedropper")
                        }
                        .labelsHidden()
                        #if os(macOS)
                        .overlay(
                            Image(systemName: "eyedropper")
                                .foregroundColor(.white)
                            )
                        #endif
                        
                        // Delete activity button
                        Button(role: .destructive, action: {
                            document.activities.remove(at: index)
                        }) {
                            Label("Delete Activity", systemImage: "trash")
                                .labelStyle(.iconOnly)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        #if !os(macOS)
                        .clipShape(Circle())
                        #endif
                        .disabled(document.activities.count == 1)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    private func maxEnergyLevel(for index: Int) -> Int {
        let totalEnergyUsed = document.activities.reduce(0) { $0 + $1.energyLevel }
        let remainingEnergy = document.maximumEnergy - (totalEnergyUsed - document.activities[index].energyLevel)
        return remainingEnergy
    }

    private func totalEnergyUsed() -> Int {
        return document.activities.reduce(0) { $0 + $1.energyLevel }
    }
}

#Preview {
    EnergyMeterView(document: .constant(ActivityDocument()))
}
