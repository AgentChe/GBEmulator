//
//  CartridgesView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 22.04.2024.
//

import SwiftUI

struct CartridgesView: View {
    let didSelect: (Cartridge) -> Void
    
    @EnvironmentObject private var gameLibraryManager: GameLibraryManager
    @State private var showFilePicker = false
    @State private var deleteCartridge: Cartridge?
    @State private var showInstruction = false

    var body: some View {
        VStack {
            Text("Cartridges.Title".localized)
                .multilineTextAlignment(.center)
                .font(Font(Fonts.Joystix.monospace(size: 18.scale)))
                .foregroundColor(Color(Appearance.mono100))
                .padding(EdgeInsets())
                .background(Color.clear)
            
            if gameLibraryManager.library.isEmpty {
                CartridgesEmptyView()
            } else {
                List(gameLibraryManager.library, id: \.id) { cartridge in
                    CartridgeView(cartridge: cartridge, didSelect: didSelect, didDelete: { cartridge in
                        deleteCartridge = cartridge
                    })
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(vertical: 8.scale, horizontal: 16.scale))
                        .listRowSeparator(.hidden)
                }
                .background(Color.clear)
                .listStyle(PlainListStyle())
                
                Spacer()
            }
            
            ActionButton(title: "Cartridges.Import".localized.uppercased(), style: .green) {
                showFilePicker = true
            }
            .padding(EdgeInsets(vertical: 8.scale))
            .sheet(isPresented: $showFilePicker) {
                FilePickerUIRepresentable(types: [.gb], allowMultiple: true) { urls in
                    gameLibraryManager.importURLs(urls: urls)
                }
                .ignoresSafeArea()
            }
            
            ActionButton(title: "Cartridges.HowImport".localized.uppercased(), style: .gray, action: {
                showInstruction = true
            })
            .padding(EdgeInsets(vertical: 8.scale))
            .sheet(isPresented: $showInstruction) {
                InstructionView()
            }
        }
        .overlay(
            Group {
                if let cartridge = deleteCartridge {
                    DimmedBackgroundView() { confirm in
                        deleteCartridge = nil
                        
                        if confirm {
                            gameLibraryManager.deleteCartridge(cartridge)
                        }
                    }
                }
            }
        )
    }
}
