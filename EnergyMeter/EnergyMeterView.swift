//
//  EnergyMeterView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct EnergyMeterView: View {
    @Binding var document: ActivityDocument
    @State private var availableEnergy: Int = 10
    
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
    EnergyMeterView(document: .constant(ActivityDocument()))
}
