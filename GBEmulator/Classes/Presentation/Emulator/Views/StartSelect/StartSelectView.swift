//
//  StartSelectView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct StartSelectView: View {
    @EnvironmentObject private var buttons: Buttons
    
    var body: some View {
        HStack {
            StartSelectButton(title: "Emulator.Select".localized, onPressed: {
                buttons.select = true
            }, onReleased: {
                buttons.select = false
            })
            
            StartSelectButton(title: "Emulator.Start".localized, onPressed: {
                buttons.start = true
            }, onReleased: {
                buttons.start = false
            })
        }
        .rotation3DEffect(Angle(degrees: -30), axis: (x: 0, y: 0, z: 1))
        .background(Color.clear)
        .padding(EdgeInsets())
    }
}
