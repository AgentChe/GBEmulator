//
//  CartridgeView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 22.04.2024.
//

import SwiftUI

struct CartridgeView: View {
    var cartridge: Cartridge
    var didSelect: ((Cartridge) -> Void)
    var didDelete: ((Cartridge) -> Void)
    
    var body: some View {
        HStack(alignment: .center) {
            Text(cartridge.title)
                .font(Font(Fonts.Joystix.monospace(size: 16.scale)))
                .foregroundColor(.black)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Image("Cartridges.Delete")
                .resizable()
                .scaledToFit()
                .frame(width: 24.scale, height: 24.scale)
                .background(Color.clear)
                .onTapGesture {
                    didDelete(cartridge)
                }
        }
        .padding(EdgeInsets(value: 16.scale))
        .overlay(
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 2.scale, dash: [5]))
                .foregroundColor(Color(integralRed: 119, green: 121, blue: 119))
            )
        .padding(EdgeInsets())
        .frame(maxWidth: .infinity)
        .onTapGesture {
            didSelect(cartridge)
        }
    }
}
