//
//  EmulatorView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct EmulatorView: View {
    let title: String
    let lcd: LCDBitmapView
    let didClose: () -> Void
    
    var body: some View {
        VStack{
            EmulatorHeaderView(title: title) {
                didClose()
            }
            .padding(EdgeInsets(value: 16.scale))
            
            lcd
                .frame(height: ScreenSize.isIphoneXFamily ? 350.scale : 270.scale)
                .padding(EdgeInsets())
            
            Spacer()
            
            HStack {
                DPadView(onLeftTap: {}, onRightTap: {}, onForwardTap: {}, onBackwardTap: {})
                
                Spacer()
                
                ABView()
            }
            .padding(EdgeInsets(horizontal: 16.scale))
            
            StartSelectView()
                .padding(EdgeInsets(t: ScreenSize.isIphoneXFamily ? 49.scale : 24.scale))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(Appearance.main100))
    }
}
