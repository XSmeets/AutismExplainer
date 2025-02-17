//
//  ContentView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("This app attempts to explain autism to people who are unfamiliar with it. Choose any of the following topics to learn more about them.")
                    .lineLimit(nil)
//                    .multilineTextAlignment(.leading)
                NavigationLink(destination: StimuliView()) {
                    Text("Stimuli")
                }
                NavigationLink(destination: OverStimulationView()) {
                    Text("Overstimulation")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
