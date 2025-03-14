//
//  EmotionCircleView.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 24/02/2025.
//

import SwiftUI

struct Segment {
    let color: Color
    let text: LocalizedStringKey
    let subSegments: [Segment]
}

struct EmotionCircleView: View {
    let segments: [Segment] = [
        Segment(color: .yellow, text: "Happy", subSegments: [
            Segment(color: .yellow.opacity(0.8), text: "Joyful", subSegments: []),
            Segment(color: .yellow.opacity(0.6), text: "Excited", subSegments: [])
        ]),
        Segment(color: .green, text: "Powerful", subSegments: [
            Segment(color: .green.opacity(0.8), text: "Confident", subSegments: []),
            Segment(color: .green.opacity(0.6), text: "Strong", subSegments: [])
        ]),
        Segment(color: .blue, text: "Normal", subSegments: [
            Segment(color: .blue.opacity(0.8), text: "Content", subSegments: []),
            Segment(color: .blue.opacity(0.6), text: "Calm", subSegments: [])
        ]),
        Segment(color: .purple, text: "Sad", subSegments: [
            Segment(color: .purple.opacity(0.8), text: "Lonely", subSegments: []),
            Segment(color: .purple.opacity(0.6), text: "Tired", subSegments: [])
        ]),
        Segment(color: .red, text: "Angry", subSegments: [
            Segment(color: .red.opacity(0.8), text: "Frustrated", subSegments: []),
            Segment(color: .red.opacity(0.6), text: "Upset", subSegments: [])
        ]),
        Segment(color: .orange, text: "Scared", subSegments: [
            Segment(color: .orange.opacity(0.8), text: "Anxious", subSegments: []),
            Segment(color: .orange.opacity(0.6), text: "Worried", subSegments: [])
        ]),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack(alignment: .leading) {
                ForEach(segments.indices, id: \.self) { index in
                    let startAngle = Angle(degrees: Double(index) / Double(segments.count) * 360.0)
                    let endAngle = Angle(degrees: Double(index + 1) / Double(segments.count) * 360.0)
                    
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    }
                    .fill(segments[index].color)

                    // Draw each sub-part in the segment
                    let subParts = segments[index].subSegments.count
                    let subAngleSize = (endAngle.degrees - startAngle.degrees) / Double(subParts)
                    
                    ForEach(segments[index].subSegments.indices, id: \.self) { subIndex in
                        let localStart = startAngle.degrees + subAngleSize * Double(subIndex)
                        let localEnd = localStart + subAngleSize
                        let localStartAngle = Angle(degrees: localStart)
                        let localEndAngle = Angle(degrees: localEnd)
                        
                        // Outer arc for sub-parts
                        Path { path in
                            path.move(to: center)
                            path.addArc(center: center,
                                        radius: 2 * radius,
                                        startAngle: localStartAngle,
                                        endAngle: localEndAngle,
                                        clockwise: false)
                        }
                        .fill(segments[index].subSegments[subIndex].color)
                        
                        let angle = localStartAngle + (localEndAngle - localStartAngle) / 2
                        let xOffset = (2 * radius) * cos(CGFloat(angle.radians))
                        let yOffset = (2 * radius) * sin(CGFloat(angle.radians))
                        
                        @State var textWidth: CGFloat = 0

                        Text(segments[index].subSegments[subIndex].text)
                        .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.07))
                        .padding([.leading], 0.02 * radius)
                        .rotationEffect(angle + .degrees(180), anchor: .leading)
                        .offset(x: center.x + xOffset, y: yOffset)
                    }
                    
                    let midAngle = startAngle + (endAngle - startAngle) / 2
                    let xOffset = radius * cos(CGFloat(midAngle.radians))
                    let yOffset = radius * sin(CGFloat(midAngle.radians))
                    
                    Text(segments[index].text)
                        .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.09))
                        .padding([.leading], 0.02 * radius)
                        .rotationEffect(midAngle + .degrees(180), anchor: .leading)
                        .offset(x: center.x + xOffset, y: yOffset)
                }
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    EmotionCircleView()
    .environment(\.locale, .init(identifier: "nl"))
}
