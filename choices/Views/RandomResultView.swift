//
//  RandomResultView.swift
//  choices
//
//  Created by liuzehui on 2024/11/20.
//

import Foundation
import SwiftUI

struct RandomResultView: View {
    let selectedItem: ListItem
    
    var body: some View {
        ResultDisplayView {
            Text(selectedItem.title)
                .font(.system(size: 80, weight: .bold))
                .multilineTextAlignment(.center)
                .padding()
                .minimumScaleFactor(0.5)
        }
    }
}
