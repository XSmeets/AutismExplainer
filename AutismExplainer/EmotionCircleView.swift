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
            Segment(color: .yellow.opacity(0.85), text: "EMOTIE_Opgewonden", subSegments: []),
            Segment(color: .yellow.opacity(0.75), text: "EMOTIE_Sensueel", subSegments: []),
            Segment(color: .yellow.opacity(0.65), text: "EMOTIE_Energiek", subSegments: []),
            Segment(color: .yellow.opacity(0.55), text: "EMOTIE_Vrolijk", subSegments: []),
            Segment(color: .yellow.opacity(0.45), text: "EMOTIE_Creatief", subSegments: []),
            Segment(color: .yellow.opacity(0.35), text: "EMOTIE_Hoopvol", subSegments: [])
        ]),
        Segment(color: .green, text: "Powerful", subSegments: [
            Segment(color: .green.opacity(0.85), text: "EMOTIE_Bewust", subSegments: []),
            Segment(color: .green.opacity(0.75), text: "EMOTIE_Trots", subSegments: []),
            Segment(color: .green.opacity(0.65), text: "EMOTIE_Gerespecteerd", subSegments: []),
            Segment(color: .green.opacity(0.55), text: "EMOTIE_Geapprecieerd", subSegments: []),
            Segment(color: .green.opacity(0.45), text: "EMOTIE_Belangrijk", subSegments: []),
            Segment(color: .green.opacity(0.35), text: "EMOTIE_Trouw", subSegments: [])
        ]),
        Segment(color: .blue, text: "Normal", subSegments: [
            Segment(color: .blue.opacity(0.85), text: "EMOTIE_Verzorgend", subSegments: []),
            Segment(color: .blue.opacity(0.75), text: "EMOTIE_Vertrouwend", subSegments: []),
            Segment(color: .blue.opacity(0.65), text: "EMOTIE_Liefhebbend", subSegments: []),
            Segment(color: .blue.opacity(0.55), text: "EMOTIE_Intiem", subSegments: []),
            Segment(color: .blue.opacity(0.45), text: "EMOTIE_Bedachtzaam", subSegments: []),
            Segment(color: .blue.opacity(0.35), text: "EMOTIE_Tevreden", subSegments: [])
        ]),
        Segment(color: .purple, text: "Sad", subSegments: [
            Segment(color: .purple.opacity(0.85), text: "EMOTIE_Moe", subSegments: []),
            Segment(color: .purple.opacity(0.75), text: "EMOTIE_Verveeld", subSegments: []),
            Segment(color: .purple.opacity(0.65), text: "EMOTIE_Eenzaam", subSegments: []),
            Segment(color: .purple.opacity(0.55), text: "EMOTIE_Depressief", subSegments: []),
            Segment(color: .purple.opacity(0.45), text: "EMOTIE_Beschaamd", subSegments: []),
            Segment(color: .purple.opacity(0.35), text: "EMOTIE_Schuldig", subSegments: [])
        ]),
        Segment(color: .red, text: "Angry", subSegments: [
            Segment(color: .red.opacity(0.85), text: "EMOTIE_Gekwetst", subSegments: []),
            Segment(color: .red.opacity(0.75), text: "EMOTIE_Vijandig", subSegments: []),
            Segment(color: .red.opacity(0.65), text: "EMOTIE_Kwaad", subSegments: []),
            Segment(color: .red.opacity(0.55), text: "EMOTIE_Egoïstisch", subSegments: []),
            Segment(color: .red.opacity(0.45), text: "EMOTIE_Haatdragend", subSegments: []),
            Segment(color: .red.opacity(0.35), text: "EMOTIE_Kritisch", subSegments: []),
        ]),
        Segment(color: .orange, text: "Scared", subSegments: [
            Segment(color: .orange.opacity(0.85), text: "EMOTIE_Verward", subSegments: []),
            Segment(color: .orange.opacity(0.75), text: "EMOTIE_Afgewezen", subSegments: []),
            Segment(color: .orange.opacity(0.65), text: "EMOTIE_Hulpeloos", subSegments: []),
            Segment(color: .orange.opacity(0.55), text: "EMOTIE_Onderdanig", subSegments: []),
            Segment(color: .orange.opacity(0.45), text: "EMOTIE_Onzeker", subSegments: []),
            Segment(color: .orange.opacity(0.35), text: "EMOTIE_Angstig", subSegments: [])
        ]),
    ]
    
    var body: some View {
        VStack {
            Text("The emotion circle can be used to find a well-understood description for one's emotions. Emotions in the inner circle show general categories, while emotions in the outer circle show more specific descriptions.")
            GeometryReader { geometry in
                let radius = min(geometry.size.width, geometry.size.height) / 4
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
                                .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.035))
                                .padding([.leading], 0.02 * radius)
                                .rotationEffect(angle + .degrees(180), anchor: .leading)
                                .offset(x: center.x + xOffset, y: yOffset)
                        }
                        
                        let midAngle = startAngle + (endAngle - startAngle) / 2
                        let xOffset = radius * cos(CGFloat(midAngle.radians))
                        let yOffset = radius * sin(CGFloat(midAngle.radians))
                        
                        Text(segments[index].text)
                            .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.045))
                            .padding([.leading], 0.02 * radius)
                            .rotationEffect(midAngle + .degrees(180), anchor: .leading)
                            .offset(x: center.x + xOffset, y: yOffset)
                    }
                }
            }
        }
        .navigationTitle("Emotion circle")
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    EmotionCircleView()
    .environment(\.locale, .init(identifier: "nl"))
}
