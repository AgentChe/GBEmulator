//
//  HomeView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import SwiftUI

struct HomeView: View {
    let didTapMenu: () -> Void
    let didTapGameLibrary: () -> Void
    let didTapWallpapers: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button(action: didTapMenu) {
                    Image("Home.Menu")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.scale, height: 24.scale)
                        .background(Color.clear)
                        .padding(EdgeInsets())
                }
            }
            .padding(EdgeInsets())
            
            HStack {
                Text("Home.Title".localized)
                    .foregroundColor(Color(Appearance.mono100))
                    .font(Font(Fonts.Joystix.monospace(size: ScreenSize.isIphoneXFamily ? 32.scale : 24.scale)))
                    .padding(EdgeInsets())
                
                Spacer()
            }
            .padding(EdgeInsets())
            
            HomeMenuItemView(item: HomeMenuItemView.Item(
                color: Color(Appearance.main400),
                title: "Home.GameLibrary".localized,
                actionTitle: "Home.Play".localized,
                imageName: "Home.GameLibrary"
            ), action: didTapGameLibrary)
            .padding(EdgeInsets(t: ScreenSize.isIphoneXFamily ? 23.scale : 16.scale))
            
            HomeMenuItemView(item: HomeMenuItemView.Item(
                color: Color(integralRed: 245, green: 191, blue: 0),
                title: "Home.Wallpapers".localized,
                actionTitle: "Home.SeeAll".localized,
                imageName: "Home.WallPapers"
            ), action: didTapWallpapers)
            .padding(EdgeInsets(t: ScreenSize.isIphoneXFamily ? 16.scale : 8.scale))
        }
        .padding(EdgeInsets(value: 16.scale))
    }
}
