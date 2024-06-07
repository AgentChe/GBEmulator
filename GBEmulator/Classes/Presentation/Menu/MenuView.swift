//
//  MenuView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import SwiftUI

struct MenuView: View {
    var didTapClose: (() -> Void)?
    var didTapTermsOfUse: (() -> Void)?
    var didTapPrivacyPolicy: (() -> Void)?
    var didTapContactUs: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    didTapClose?()
                }) {
                    Image("Back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.scale, height: 24.scale)
                        .padding(EdgeInsets())
                }
                
                Text("Menu.Title".localized)
                    .multilineTextAlignment(.center)
                    .font(Font(Fonts.Joystix.monospace(size: 18.scale)))
                    .foregroundColor(Color(Appearance.mono100))
                    .padding(EdgeInsets())
                
                Spacer()
            }
            .padding(EdgeInsets(b: 16.scale))
            
            MenuRouteView(title: "Menu.TermsOfUse".localized)
                .padding(EdgeInsets(value: 16.scale))
                .onTapGesture {
                    didTapTermsOfUse?()
                }
            
            MenuRouteView(title: "Menu.PrivacyPolicy".localized)
                .padding(EdgeInsets(value: 16.scale))
                .onTapGesture {
                    didTapPrivacyPolicy?()
                }
            
            MenuRouteView(title: "Menu.ContactUs".localized)
                .padding(EdgeInsets(value: 16.scale))
                .onTapGesture {
                    didTapContactUs?()
                }
            
            Spacer()
        }
        .padding(EdgeInsets(value: 16.scale))
    }
}
