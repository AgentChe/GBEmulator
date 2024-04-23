//
//  ActionButton.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct ActionButton: View {
    enum Style {
        case green, gray, lightGray
    }
    
    let title: String
    let style: Style
    let action: () -> Void
    
    var body: some View {
            Button(action: {
                action()
            }) {
                Text(title)
                    .font(Font(Fonts.Joystix.monospace(size: 16.scale)))
                    .foregroundColor(Color(Appearance.mono100))
                    .frame(width: 358.scale, height: 54.scale)
                    .background(style.backgroundColor)
                    .cornerRadius(12.scale)
                    .shadow(color: style.shadowColor, radius: 0, x: 0, y: 12.scale)
                    .padding(EdgeInsets())
            }
            .padding(EdgeInsets())
        }
}

// MARK: Private
private extension ActionButton.Style {
    var backgroundColor: Color {
        switch self {
        case .green:
            return Color(Appearance.main400)
        case .gray:
            return Color(Appearance.main200)
        case .lightGray:
            return Color(Appearance.main100)
        }
    }
    
    var shadowColor: Color {
        switch self {
        case .green:
            return Color(red: 0.247, green: 0.502, blue: 0.196)
        case .gray, .lightGray:
            return Color(Appearance.main300)
        }
    }
}
