//
//  ABView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct ABView: View {
    @EnvironmentObject private var buttons: Buttons
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35.scale)
                .foregroundColor(Color(Appearance.main200))
                .frame(width: 138.scale, height: 70.scale)
                .padding(EdgeInsets())
            
            HStack {
                ABButton(title: "B", onPressed: {
                    buttons.b = true
                }, onReleased: {
                    buttons.b = false
                })
                
                ABButton(title: "A", onPressed: {
                    buttons.a = true
                }, onReleased: {
                    buttons.a = false
                })
            }
            .padding(EdgeInsets(t: 33.scale))
        }
        .rotation3DEffect(Angle(degrees: -30), axis: (x: 0, y: 0, z: 1))
        .background(Color.clear)
        .padding(EdgeInsets())
    }
}
