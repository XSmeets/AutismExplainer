//
//  StimuliView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct Stimulus {
    var name: String
    var imageName: String
}

let stimuli = [
    Stimulus(name: "Visual", imageName: "eye"),
    Stimulus(name: "Auditory", imageName: "ear"),
    Stimulus(name: "Taste", imageName: "fork.knife"),
    Stimulus(name: "Smell", imageName: "nose"),
    Stimulus(name: "Touch", imageName: "hand.thumbsup")
]

struct StimuliView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stimuli")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("There are many kinds of stimuli. The most important ones are:")
            ForEach(stimuli, id: \.name) { stimulus in
                HStack {
                    Text("• ") + Text(LocalizedStringKey(stimulus.name))
                    Image(systemName: stimulus.imageName)
                }
            }
            Text("These are not the only stimuli in existence. Others include:")
            HStack {
                Text("• Temperature")
                Image(systemName: "thermometer")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    StimuliView()
    .environment(\.locale, .init(identifier: "nl"))
}
