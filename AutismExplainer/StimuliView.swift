//
//  StimuliView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

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

#Preview {
    StimuliView()
}
