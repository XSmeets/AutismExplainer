//
//  InformationView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 14/03/2025.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("AutismExplainer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                ScrollView {
                    Text("This app attempts to explain autism to people who are unfamiliar with it. Choose any of the following topics to learn more about them.")
                        .lineLimit(nil)
                    NavigationLink(destination: StimuliView()) {
                        Text("Stimuli")
                    }
                    NavigationLink(destination: OverStimulationView()) {
                        Text("Overstimulation")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .navigationTitle("Information")
    }
}