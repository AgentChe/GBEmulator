//
//  InstructionView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16.scale) {
                Text("Instruction.Title".localized.uppercased())
                    .font(Font(Fonts.Joystix.monospace(size: 18.scale)))
                    .foregroundColor(Color(Appearance.mono100))
                    .padding(EdgeInsets())
                    .background(Color.clear)
                
                CustomTextView(text: "Instruction.Part1".localized)
                
                CustomLinkView(text: "Instruction.Part2".localized, link: "Instruction.Part3".localized)
                
                CustomTextView(text: "Instruction.Part4".localized)
                
                CustomLinkView(text: "-", link: "Instruction.Part5".localized)
                
                CustomLinkView(text: "-", link: "Instruction.Part6".localized)
                
                CustomLinkView(text: "-", link: "Instruction.Part7".localized)
                
                CustomLinkView(text: "-", link: "Instruction.Part8".localized)
                
                CustomTextView(text: "Instruction.Part9".localized)
                
                CustomTextView(text: "Instruction.Part10".localized)
            }
            .padding(EdgeInsets(value: 16.scale))
        }
        .background(Color(Appearance.main100))
    }
}

private struct CustomTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(Color(Appearance.mono100))
            .font(Font(Fonts.RobotoMono.regular(size: 16.scale)))
            .padding(EdgeInsets())
            .background(Color.clear)
    }
}

private struct CustomLinkView: View {
    let text: String
    let link: String

    var body: some View {
        (Text(text)
            .foregroundColor(Color(Appearance.mono100))
            .font(Font(Fonts.RobotoMono.regular(size: 16.scale)))
        +
        Text(link)
            .underline(color: Color(Appearance.mono100))
            .foregroundColor(Color(Appearance.mono100)))
            .onTapGesture {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            }
    }
}
