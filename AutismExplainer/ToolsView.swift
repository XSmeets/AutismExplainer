//
//  ToolsView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 14/03/2025.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

struct ToolsView: View {
    @Environment(\.openWindow) private var openWindow
    #if os(visionOS)
    @Environment(\.openURL) var openURL
    #endif
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("This app provides several tools for people with autism.")
                ScrollView {
                    NavigationLink(destination: EmotionCircleView()) {
                        Text("Emotion circle")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .navigationTitle("Tools")
    }
}

#Preview {
    ToolsView()
    .environment(\.locale, .init(identifier: "nl"))
}
