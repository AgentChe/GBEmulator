//
//  PressableView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import SwiftUI

struct PressableView<C: View> : View {
    @Binding var pressedBinding: Bool
    @State private var pressed = false {
        didSet {
            pressedBinding = pressed
            haptics.impactOccurred(intensity: 0.5);
            if let cb = pressed ? onPressedCallback : onReleasedCallback {
                cb()
            }
        }
    }
    
    private let getChildView: (Bool) -> C
    private var haptics: UIImpactFeedbackGenerator  = UIImpactFeedbackGenerator(style: .medium)
    private var onPressedCallback: (() -> Void)?
    private var onReleasedCallback: (() -> Void)?
    
    var body: some View {
        getChildView(pressed)
            .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture( minimumDistance: 0, coordinateSpace: .local)
            .onChanged { _ in
                if !pressed {
                    pressed = true
                }
            }
            .onEnded { _ in
                if pressed {
                    pressed = false
                }
            }
    }
}

extension PressableView {
    init (_ getChildView: @escaping (Bool) -> C) {
        self._pressedBinding = Binding.constant(false)
        self.getChildView = getChildView
    }
    
    init (_ pressed: Binding<Bool>, _ getChildView: @escaping (Bool) -> C) {
        self._pressedBinding = pressed
        self.getChildView = getChildView
    }
    
    func impact(_ strength: UIImpactFeedbackGenerator.FeedbackStyle) -> Self {
        var next = self;
        next.haptics = UIImpactFeedbackGenerator(style: strength);
        
        return next;
    }
    
    func onPressed(_ onPressedCallback: @escaping () -> Void) -> Self {
        var next = self
        next.onPressedCallback = onPressedCallback
        
        return next;
    }
    
    func onReleased(_ onReleasedCallback: @escaping () -> Void) -> Self {
        var next = self
        next.onReleasedCallback = onReleasedCallback
        
        return next;
    }
}
