//
//  ContentView.swift
//  choices
//
//  Created by liuzehui on 2024/11/19.
//

import SwiftUI
import UIKit

// 添加 Color 扩展来计算对比色
extension Color {
    var complementary: Color {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0, 0]
        
        // 确保至少有 3 个颜色分量（RGB）
        let red = components.count >= 1 ? components[0] : 0
        let green = components.count >= 2 ? components[1] : 0
        let blue = components.count >= 3 ? components[2] : 0
        
        // 计算对比色
        return Color(
            red: Double(1.0 - red),
            green: Double(1.0 - green),
            blue: Double(1.0 - blue)
        )
    }
}

struct HomeView: View {

    @State private var showSavedLists = false
    @StateObject private var viewModel = ListsViewModel()
    @State private var showingCreateSheet = false  // 控制 sheet 显示
    @State private var showDiceResult = false  // 添加这行
    let backgroundColor = Color(red: 0.4, green: 0.6, blue: 0.8)
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            // 使用GeometryReader来实现均匀分布
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Spacer(minLength: geometry.size.height * 0.15)
                    CustomButton(title: "清单", backgroundColor: backgroundColor) {
                        showSavedLists = true
                    }
                        .frame(height: geometry.size.height * 0.2)
                        .fullScreenCover(isPresented: $showSavedLists) {  // 使用 fullScreenCover 代替 sheet
                            ListsView()
                        }
                    Spacer()
                    
                    CustomButton(title: "🎲", backgroundColor: backgroundColor) {
                        showDiceResult = true
                    }
                    .frame(height: geometry.size.height * 0.2)
                    .fullScreenCover(isPresented: $showDiceResult) {
                        DiceResultView()
                    }
                    
                    Spacer(minLength: geometry.size.height * 0.15)
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

struct CustomButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size:60, weight: .bold)) // 增大字体
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(backgroundColor.opacity(0.3))
                )
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
