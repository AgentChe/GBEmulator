//
//  ABButton.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct ABButton: View {
    let title: String
    let onPressed: () -> Void
    let onReleased: () -> Void
    
    var body: some View {
        VStack {
            PressableView { pressed in
                Image("Emulator.ABButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52.scale, height: 52.scale)
                    .padding(EdgeInsets())
                    .scaleEffect(pressed ? 1.2 : 1)
                    .animation(.spring().speed(4), value: pressed)
            }
            .onPressed(onReleased)
            .onReleased(onReleased)
            .padding(EdgeInsets())
            
            Text(title)
                .foregroundColor(Color(Appearance.mono100))
                .font(Font(Fonts.Joystix.monospace(size: 14.scale)))
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(t: 13.scale))
        }
        .background(Color.clear)
        .padding(EdgeInsets())
    }
}
