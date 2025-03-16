//
//  AutismExplainerApp.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

@main
struct AutismExplainerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
    .environment(\.locale, .init(identifier: "nl"))
}
