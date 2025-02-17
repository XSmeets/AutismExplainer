//
//  OverStimulationView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

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
                HStack {
                    Text("• Tiredness")
                    Image(systemName: "zzz")
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
}
