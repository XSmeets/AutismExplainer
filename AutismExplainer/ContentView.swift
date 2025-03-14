//
//  ContentView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            InformationView()
                .tabItem {
                    Label("Information", systemImage: "info.circle")
                }
            ToolsView()
                .tabItem {
                    Label("Tools", systemImage: "wrench")
                }
        }
    }
}

#Preview {
    ContentView()
    .environment(\.locale, .init(identifier: "nl"))
}
