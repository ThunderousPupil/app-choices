//
//  DiceResultView.swift
//  choices
//
//  Created by liuzehui on 2024/11/20.
//

import Foundation
import SwiftUI

struct DiceResultView: View {
    private let diceNumber = Int.random(in: 1...6)
    
    var body: some View {
        ResultDisplayView {
            Text("\(diceNumber)")
                .font(.system(size: 120, weight: .bold))
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
