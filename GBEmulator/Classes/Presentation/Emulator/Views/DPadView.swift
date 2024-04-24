//
//  DPadView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct CustomButton: View {
    var action: () -> Void
    var color: Color
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var rotationDegrees: Double
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .frame(width: width, height: height)
                .rotation3DEffect(.degrees(rotationDegrees), axis: (x: 0, y: 1, z: 0))
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct DPadView: View {
    @EnvironmentObject private var buttons: Buttons
    
    var onLeftTap: () -> Void
    var onRightTap: () -> Void
    var onForwardTap: () -> Void
    var onBackwardTap: () -> Void

    var body: some View {
        ZStack {
            // Основной большой круг
            Circle()
                .fill(Color(Appearance.main200))
                .frame(width: 176.scale, height: 176.scale)
            
            // Центральный крест из четырех кнопок, составленный из двух перекрещенных прямоугольников
            VStack(spacing: 0) {
                PressableView { pressed in
                    Rectangle()
                        .fill(Color(integralRed: 116, green: 117, blue: 116))
                        .frame(width: 50.scale, height: 41.scale)
                        .padding(EdgeInsets())
                        .cornerRadius(8.scale, corners: .topLeft)
                        .cornerRadius(8.scale, corners: .topRight)
                        .scaleEffect(pressed ? 1.2 : 1)
                        .animation(.spring().speed(4), value: pressed)
                }
                .onPressed {
                    buttons.up = true
                }
                .onReleased {
                    buttons.up = false
                }
                .padding(EdgeInsets())
                
                HStack(spacing: 0) {
                    PressableView { pressed in
                        Rectangle()
                            .fill(Color(integralRed: 116, green: 117, blue: 116))
                            .frame(width: 41.scale, height: 50.scale)
                            .padding(EdgeInsets())
                            .cornerRadius(8.scale, corners: .topLeft)
                            .cornerRadius(8.scale, corners: .bottomLeft)
                            .scaleEffect(pressed ? 1.2 : 1)
                            .animation(.spring().speed(4), value: pressed)
                    }
                    .onPressed {
                        buttons.left = true
                    }
                    .onReleased {
                        buttons.left = false
                    }
                    .padding(EdgeInsets())
                    
                    Rectangle()
                        .fill(Color(integralRed: 116, green: 117, blue: 116))
                        .frame(width: 41.scale, height: 50.scale)
                        .padding(EdgeInsets())
                    
                    PressableView { pressed in
                        Rectangle()
                            .fill(Color(integralRed: 116, green: 117, blue: 116))
                            .frame(width: 41.scale, height: 50.scale)
                            .padding(EdgeInsets())
                            .cornerRadius(8.scale, corners: .topRight)
                            .cornerRadius(8.scale, corners: .bottomRight)
                            .scaleEffect(pressed ? 1.2 : 1)
                            .animation(.spring().speed(4), value: pressed)
                    }
                    .onPressed {
                        buttons.right = true
                    }
                    .onReleased {
                        buttons.right = false
                    }
                    .padding(EdgeInsets())
                }
                .padding(EdgeInsets())
                
                PressableView { pressed in
                    Rectangle()
                        .fill(Color(integralRed: 116, green: 117, blue: 116))
                        .frame(width: 50.scale, height: 41.scale)
                        .padding(EdgeInsets())
                        .cornerRadius(8.scale, corners: .bottomLeft)
                        .cornerRadius(8.scale, corners: .bottomRight)
                        .scaleEffect(pressed ? 1.2 : 1)
                        .animation(.spring().speed(4), value: pressed)
                }
                .onPressed {
                    buttons.down = true
                }
                .onReleased {
                    buttons.down = false
                }
                .padding(EdgeInsets())
            }
            .frame(width: 132.scale, height: 132.scale)
            .padding(EdgeInsets())
            
            // Маленький центральный круг
            Circle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.294, green: 0.294, blue: 0.294),
                        Color(red: 0.510, green: 0.518, blue: 0.510)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 44.scale, height: 44.scale)
            
            // Стрелки, позиционированные согласно вашему описанию
            Triangle()
                .fill(Color.gray)
                .frame(width: 14.scale, height: 11.scale)
                .offset(x: 0, y: -75.scale) // верх
            Triangle()
                .fill(Color.gray)
                .frame(width: 14.scale, height: 11.scale)
                .rotationEffect(.degrees(180))
                .offset(x: 0, y: 75.scale) // низ
            Triangle()
                .fill(Color.gray)
                .frame(width: 14.scale, height: 11.scale)
                .rotationEffect(.degrees(270))
                .offset(x: -75.scale, y: 0) // лево
            Triangle()
                .fill(Color.gray)
                .frame(width: 14.scale, height: 11.scale)
                .rotationEffect(.degrees(90))
                .offset(x: 75.scale, y: 0) // право
        }
    }
}
