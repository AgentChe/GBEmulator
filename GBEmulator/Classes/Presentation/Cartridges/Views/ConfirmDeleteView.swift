//
//  ConfirmDeleteView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct DimmedBackgroundView: View {
    let didResult: (Bool) -> Void

    var body: some View {
        Color(Appearance.mono100.withAlphaComponent(0.8))
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    ActionButton(title: "Cartridges.Confirm.Delete".localized.uppercased(), style: .green) {
                        didResult(true)
                    }
                    .padding(EdgeInsets(vertical: 8.scale))
                    
                    ActionButton(title: "Cartridges.Confirm.Close".localized.uppercased(), style: .lightGray) {
                        didResult(false)
                    }
                    .padding(EdgeInsets(vertical: 8.scale))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.clear)
            )
    }
}
