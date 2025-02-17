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

struct StimuliView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("There are many kinds of stimuli. The most important ones are:")
            HStack {
                Text("• Visual")
                Image(systemName: "eye")
            }
            HStack {
                Text("• Auditory")
                Image(systemName: "ear")
            }
            HStack {
                Text("• Taste")
                Image(systemName: "fork.knife")
            }
            HStack {
                Text("• Smell")
                Image(systemName: "nose")
            }
            HStack {
                Text("• Touch")
                Image(systemName: "hand.thumbsup")
            }
        }
        .padding()
    }
}

struct OverStimulationView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Overstimulation occurs when a person is exposed to too many stimuli. People with autism tend to be less capable of filtering out stimuli, which can make them more susceptible to overstimulation.").lineLimit(nil).multilineTextAlignment(.leading)
            VStack(alignment: .leading) {
                Text("Overstimulation typically makes a person respond more instinctively, in an attempt to escape the stimuli. This can be expressed through the following symptoms:").lineLimit(nil).multilineTextAlignment(.leading)
                HStack {
                    Text("• Aggression")
                    Image(systemName: "figure.boxing")
                }
                HStack {
                    Text("• Panic")
                    Image(systemName: "brain.head.profile.fill")
                }
                HStack {
                    Text("• Crying")
                    Image(systemName: "drop.halffull")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    ContentView()
}
