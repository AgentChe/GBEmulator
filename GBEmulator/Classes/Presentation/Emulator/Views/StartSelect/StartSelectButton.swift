//
//  StartSelectButton.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct StartSelectButton: View {
    let title: String
    let onPressed: () -> Void
    let onReleased: () -> Void
    
    var body: some View {
        VStack {
            PressableView { pressed in
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 11.5.scale)
                            .foregroundColor(Color(Appearance.main200))
                            .frame(width: 60.scale, height: 23.scale)
                            .padding(EdgeInsets())
                        
                        Image("Emulator.StartSelectButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50.scale, height: 15.scale)
                            .padding(EdgeInsets())
                            .scaleEffect(pressed ? 1.2 : 1)
                            .animation(.spring().speed(4), value: pressed)
                    }
                    
                    Text(title)
                        .foregroundColor(Color(Appearance.mono100))
                        .font(Font(Fonts.Joystix.monospace(size: 14.scale)))
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(t: 8.scale))
                }
                .padding(EdgeInsets())
                .background(Color.clear)
            }
            .onPressed(onPressed)
            .onReleased(onReleased)
            .padding(EdgeInsets())
        }
        .background(Color.clear)
        .padding(EdgeInsets())
    }
}
