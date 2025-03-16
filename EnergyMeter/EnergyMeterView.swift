//
//  EnergyMeterView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct EnergyMeterView: View {
    var document: ObservedObject<ActivityDocument>.Wrapper
    @State private var availableEnergy: Int = 10
    
//    init(document: ActivityDocument) {
//        self.document = document
//    }
    
//    init(_ url: URL) {
//        let data = try! Data(contentsOf: url)
//        do {
//            self.document = try ActivityDocument(data: data)
//        } catch {
//            self.document = ActivityDocument()
//        }
//    }
    
    var body: some View {
        ScrollView {
            VStack {
                // Energy usage overview
                VStack {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            ForEach(document.activities.indices, id: \.self) { index in
                                let fraction = CGFloat(document.activities[index].energyLevel.wrappedValue) / CGFloat(availableEnergy)
                                let width = fraction * geometry.size.width
                                Rectangle()
                                    .fill(document.activities[index].color)
                                    .frame(width: width)
                                    .overlay(
                                        Text(document.activities[index].name)
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
//                ForEach(document.activities.indices, id: \.self) { index in
//                    HStack {
//                        TextField("Activity", text: $document.activities[index].name)
//                            .padding(4)
//                            .background(document.activities[index].color.opacity(0.3))
//                            .cornerRadius(4)
//                        #if os(tvOS)
//                            TextField("Energy Level", value: $document.activities[index].energyLevel, formatter: NumberFormatter())
//                                .keyboardType(.numberPad)
//                                .padding(4)
//                                .background(document.activities[index].color.opacity(0.3))
//                                .cornerRadius(4)
//                        #else
//                            Stepper(value: $document.activities[index].energyLevel, in: 1...maxEnergyLevel(for: index)) {
//                                Text("\(document.activities[index].energyLevel)")
//                                    .padding(4)
//                                    .background(document.activities[index].color.opacity(0.3))
//                                    .cornerRadius(4)
//                            }
//                        #endif
//                    }
//                    .padding(.horizontal)
//                }
                ForEach(document.activities.indices) { index in
                    ActivityRowView(activity: Binding(
                        get: { document.activities[index] },
                        set: { document.activities[index] = $0 }
                    ))
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
        let totalEnergyUsed = document.activities.reduce(0) { partial, activity in
            partial + activity.energyLevel.wrappedValue
        }
        let remainingEnergy = availableEnergy - (totalEnergyUsed - document.activities[index].energyLevel.wrappedValue)
        return remainingEnergy
    }

    private func totalEnergyUsed() -> Int {
        return document.activities.reduce(0) { partial, activity in
            partial + activity.energyLevel.wrappedValue
        }
    }
}

struct ActivityRowView: View {
    @Binding var activity: Activity  // ✅ Binding to a single Activity

    var body: some View {
        HStack {
            TextField("Activity", text: activity.name)
                .padding(4)
                .background(activity.color.opacity(0.3))
                .cornerRadius(4)
            
            #if os(tvOS)
            TextField("Energy Level", value: activity.energyLevel, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .padding(4)
                .background(activity.color.opacity(0.3))
                .cornerRadius(4)
            #else
            Stepper(value: activity.energyLevel, in: 1...100) {
                Text("\(activity.energyLevel)")
            }
            #endif
        }
        .padding(.horizontal)
    }
}

//#Preview {
//   EnergyMeterView(document: ActivityDocument())
//}
