//
//  EnergyMeterView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 17/02/2025.
//

import SwiftUI

struct EnergyMeterView: View {
    @State private var energyLevel: Int = 1
    
    var body: some View {
        Text("")
        HStack {
            TextField("Activity", text: .constant(""))
            Stepper(value: $energyLevel, in: 1...10) {
                Text("\(energyLevel)")
            }
        }
    }
}

#Preview {
    EnergyMeterView()
}
