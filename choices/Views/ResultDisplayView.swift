//
//  DiceResultView.swift
//  choices
//
//  Created by liuzehui on 2024/11/20.
//

import Foundation
import SwiftUI

// 烟花粒子效果
struct FireworkParticlesGeometryEffect: GeometryEffect {
    var time: Double
    var angle: Double
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let distance = 300.0 * time
        let xTranslation = distance * cos(angle)
        let yTranslation = distance * sin(angle)
        
        let affineTransform = CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTransform)
    }
}

// 烟花粒子
struct FireworkParticle: View {
    let angle: Double
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .fill(Color(
                red: .random(in: 0.7...1),
                green: .random(in: 0.7...1),
                blue: .random(in: 0.7...1)
            ))
            .frame(width: 8, height: 8)
            .modifier(FireworkParticlesGeometryEffect(
                time: isAnimating ? 1 : 0,
                angle: angle
            ))
            .opacity(isAnimating ? 0 : 1)
            .animation(
                Animation.easeOut(duration: 1.5),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

// 结果显示视图
struct ResultDisplayView<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showFireworks = false
    let content: Content
    
    private let backgroundColor: Color = Color(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1)
    )
    
    private var textColor: Color {
        let components = UIColor(backgroundColor).cgColor.components ?? [0, 0, 0, 0]
        let red = components.count >= 1 ? components[0] : 0
        let green = components.count >= 2 ? components[1] : 0
        let blue = components.count >= 3 ? components[2] : 0
        
        let brightness = (red + green + blue) / 3
        if brightness > 0.5 {
            return Color.black
        } else {
            return Color.white
        }
    }
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .opacity(0.9)
                .ignoresSafeArea()
            
            if showFireworks {
                ForEach(0..<48, id: \.self) { index in
                    FireworkParticle(angle: Double(index) * (2 * .pi / 48))
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(textColor)
                    }
                    .padding()
                }
                Spacer()
            }
            
            content
                .foregroundColor(textColor)
        }
        .onAppear {
            withAnimation {
                showFireworks = true
            }
        }
    }
}
