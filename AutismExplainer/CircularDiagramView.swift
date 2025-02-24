//
//  CircularDiagramView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 24/02/2025.
//

import SwiftUI

struct CircularDiagramView: View {
    let segments: [(color: Color, text: String)] = [
        (.red, "Angry"),
        (.orange, "Scared"),
        (.yellow, "Happy"),
        (.green, "Powerful"),
        (.blue, "Normal"),
        (.purple, "Sad")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                ForEach(0..<segments.count) { index in
                    let startAngle = Angle(degrees: Double(index) / Double(segments.count) * 360.0)
                    let endAngle = Angle(degrees: Double(index + 1) / Double(segments.count) * 360.0)
                    
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    }
                    .fill(segments[index].color)
                    
                    let angle = startAngle + (endAngle - startAngle) / 2
                    let xOffset = radius / 2 * cos(CGFloat(angle.radians))
                    let yOffset = radius / 2 * sin(CGFloat(angle.radians))
                    
                    Text(segments[index].text)
                        .rotationEffect(angle - .degrees(90))
                        .position(x: center.x + xOffset, y: center.y + yOffset)
                }
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    CircularDiagramView()
}
