//
//  ToolsView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 14/03/2025.
//

import SwiftUI

struct ToolsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("This app provides several tools for people with autism.")
                ScrollView {
                    NavigationLink(destination: EmotionCircleView()) {
                        Text("Emotion circle")
                    }
                    NavigationLink(destination: EnergyMeterView(document: ActivityDocument())) {
                        Text("Energy Meter")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .navigationTitle("Tools")
    }
}
