//
//  EmulatorHeaderView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct EmulatorHeaderView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(title)
                .font(Font(Fonts.Joystix.monospace(size: 18.scale)))
                .foregroundColor(Color(Appearance.mono100))
                .padding(EdgeInsets())
            
            Spacer()
            
            Button(action: action) {
                Image("Emulator.Menu")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24.scale, height: 24.scale)
                    .padding(EdgeInsets())
            }
        }
        .padding(EdgeInsets())
    }
}
