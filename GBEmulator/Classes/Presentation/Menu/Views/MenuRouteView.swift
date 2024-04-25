//
//  MenuRouteView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import SwiftUI

struct MenuRouteView: View {
    var title: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(Font(Fonts.Joystix.monospace(size: 16.scale)))
                .foregroundColor(Color(Appearance.mono100))
            
            Spacer()
        }
        .padding(EdgeInsets(value: 16.scale))
        .overlay(
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 2.scale, dash: [5]))
                .foregroundColor(Color(integralRed: 119, green: 121, blue: 119))
            )
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets())
    }
}
