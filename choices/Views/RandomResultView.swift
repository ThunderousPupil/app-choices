//
//  RandomResultView.swift
//  choices
//
//  Created by liuzehui on 2024/11/20.
//

import Foundation
import SwiftUI

struct FireworkParticlesGeometryEffect: GeometryEffect {
    var time: Double
    var angle: Double
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let distance = 300.0 * time  // 增加炸开范围
        let xTranslation = distance * cos(angle)
        let yTranslation = distance * sin(angle)
        
        let affineTransform = CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTransform)
    }
}

struct FireworkParticle: View {
    let angle: Double
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .fill(Color(
                red: .random(in: 0.7...1),    // 提高亮度
                green: .random(in: 0.7...1),
                blue: .random(in: 0.7...1)
            ))
            .frame(width: 8, height: 8)       // 增大粒子尺寸
            .modifier(FireworkParticlesGeometryEffect(
                time: isAnimating ? 1 : 0,
                angle: angle
            ))
            .opacity(isAnimating ? 0 : 1)
            .animation(
                Animation.easeOut(duration: 1.5),  // 增加动画时间，移除重复
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

struct RandomResultView: View {
    @Environment(\.dismiss) private var dismiss
    let selectedItem: ListItem
    @State private var showFireworks = false
    
    // 生成完全随机的背景色
    private let backgroundColor: Color = Color(
        red: .random(in: 0...1),      // 完整的颜色范围
        green: .random(in: 0...1),
        blue: .random(in: 0...1)
    )
    
    // 生成对比色作为文字颜色
    private var textColor: Color {
        let components = UIColor(backgroundColor).cgColor.components ?? [0, 0, 0, 0]
        let red = components.count >= 1 ? components[0] : 0
        let green = components.count >= 2 ? components[1] : 0
        let blue = components.count >= 3 ? components[2] : 0
        
        // 如果背景色太亮，使用深色文字；如果背景色太暗，使用浅色文字
        let brightness = (red + green + blue) / 3
        if brightness > 0.5 {
            return Color.black
        } else {
            return Color.white
        }
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .opacity(0.9)
                .ignoresSafeArea()
            
            // 烟花效果
            if showFireworks {
                ForEach(0..<48, id: \.self) { index in
                    FireworkParticle(angle: Double(index) * (2 * .pi / 48))
                }
            }
            
            // 关闭按钮
            VStack {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(textColor)  // 使用对比色
                    }
                    .padding()
                }
                Spacer()
            }
            
            // 结果文本
            Text(selectedItem.title)
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(textColor)  // 使用对比色
                .multilineTextAlignment(.center)
                .padding()
                .minimumScaleFactor(0.5)
        }
        .onAppear {
            withAnimation {
                showFireworks = true
            }
        }
    }
}
