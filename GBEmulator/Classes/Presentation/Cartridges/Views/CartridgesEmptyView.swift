//
//  CartridgesEmptyView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct CartridgesEmptyView: View {
    var body: some View {
        VStack {
            Text("Cartridges.Empty.Title".localized)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(Font(Fonts.Joystix.monospace(size: 16.scale)))
                .foregroundColor(Color(Appearance.mono100))
                .padding(EdgeInsets())
                .background(Color.clear)
            
            Image("Cartridges.Empty")
                .resizable()
                .scaledToFit()
                .frame(width: 135.scale, height: 124.scale)
                .background(Color.clear)
            
            Text("Cartridges.Empty.SubTitle".localized)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(Font(Fonts.RobotoMono.regular(size: 16.scale)))
                .foregroundColor(Color(Appearance.mono100))
                .padding(EdgeInsets())
                .background(Color.clear)
        }
    }
}
