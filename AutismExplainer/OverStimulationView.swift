//
//  OverStimulationView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct Symptom: Identifiable {
    var id = UUID()
    var name: LocalizedStringKey
    var imageName: String
}

let symptoms = [
    Symptom(name: "Aggression", imageName: "figure.boxing"),
    Symptom(name: "Panic", imageName: "brain.head.profile.fill"),
    Symptom(name: "Crying", imageName: "drop.halffull"),
    Symptom(name: "Tiredness", imageName: "zzz")
]

struct OverStimulationView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Overstimulation")
                .font(.largeTitle)
                .fontWeight(.bold)
            (Text("Overstimulation") + Text(" occurs when a person is exposed to too many stimuli. People with autism tend to be less capable of filtering out stimuli, which can make them more susceptible to overstimulation.")).lineLimit(nil).multilineTextAlignment(.leading)
            VStack(alignment: .leading) {
                (Text("Overstimulation") + Text(" typically makes a person respond more instinctively, in an attempt to escape the stimuli. This can be expressed through the following symptoms:")).lineLimit(nil).multilineTextAlignment(.leading)
                ForEach(symptoms) { symptom in
                    HStack {
                        Text("• ") + Text(symptom.name)
                        Image(systemName: symptom.imageName)
                    }
                }
                Text("Limiting exposure to stimuli can help prevent overstimulation, which can, in turn, prevent the symptoms mentioned above.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    OverStimulationView()
    .environment(\.locale, .init(identifier: "nl"))
}
