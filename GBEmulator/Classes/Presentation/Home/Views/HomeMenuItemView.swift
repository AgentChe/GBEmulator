//
//  HomeMenuItemView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import SwiftUI

struct HomeMenuItemView: View {
    struct Item {
        let color: Color
        let title: String
        let actionTitle: String
        let imageName: String
    }
    
    let item: Item
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text(item.title)
                .foregroundColor(Color(Appearance.mono100))
                .font(Font(Fonts.Joystix.monospace(size: 24.scale)))
                .padding(EdgeInsets(vertical: ScreenSize.isIphoneXFamily ? 24.scale : 16.scale, horizontal: 16.scale))
            
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 128.scale, height: 109.scale)
                .background(Color.clear)
                .padding(EdgeInsets())
            
            ActionButton(
                title: item.actionTitle, 
                style: .lightGray,
                size: CGSize(width: 326.scale, height: ScreenSize.isIphoneXFamily ? 66.scale : 54.scale),
                action: action
            )
            .padding(EdgeInsets(vertical: ScreenSize.isIphoneXFamily ? 24.scale : 16.scale, horizontal: 16.scale))
        }
        .background(item.color)
    }
}
