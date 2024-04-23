import Foundation
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

struct DraggableView<C: View> : View {
    @Binding var dragOffsetBinding: CGFloat
    @Binding var draggingBinding: Bool
    
    @State private var dragging = false
    @State private var prevDragTranslation = CGSize.zero
    @State private var dragOffset = CGFloat(0) {
        didSet {
            dragOffsetBinding = dragOffset
            if let cb = onDraggedCallback {
                cb(dragOffset)
            }
        }
    }
    
    private let getChildView: (CGFloat, Bool) -> C
    private var onDraggedCallback: ((CGFloat) -> Void)?
    private var onReleasedCallback: ((CGFloat) -> Void)?
    
    var body: some View {
        getChildView(dragOffset, dragging)
            .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                let dragAmount = val.translation.height - prevDragTranslation.height
                dragOffset += dragAmount
                prevDragTranslation = val.translation
                if !dragging {
                    dragging = true
                }
            }
            .onEnded { val in
                prevDragTranslation = .zero
                if let cb = onReleasedCallback {
                    cb(dragOffset)
                }
                dragOffset = 0
                if dragging {
                    dragging = false
                }
            }
    }
}

extension DraggableView {
    init (_ dragOffsetBinding: Binding<CGFloat>, _ draggingBinding: Binding<Bool>, _ getChildView: @escaping (CGFloat, Bool) -> C) {
        self._dragOffsetBinding = dragOffsetBinding
        self._draggingBinding = draggingBinding
        self.getChildView = getChildView
    }
    
    init (_ dragOffsetBinding: Binding<CGFloat>,  _ getChildView: @escaping (CGFloat, Bool) -> C) {
        self.init(dragOffsetBinding, Binding.constant(false), getChildView)
    }
    
    init (_ getChildView: @escaping (CGFloat, Bool) -> C) {
        self.init(Binding.constant(CGFloat(0)), getChildView)
    }
    
    func onDragged(_ onDraggedCallback: @escaping (CGFloat) -> Void) -> Self {
        var next = self
        next.onDraggedCallback = onDraggedCallback
        
        return next;
    }
    
    func onReleased(_ onReleasedCallback: @escaping (CGFloat) -> Void) -> Self {
        var next = self
        next.onReleasedCallback = onReleasedCallback
        
        return next;
    }
}

struct GameButtonView<S>: View where S : Shape {
    var shape: S
    var label: String?
    var width: CGFloat = 50
    var height: CGFloat = 50
    var onPressed: () -> Void
    var onReleased: () -> Void
    
    var body: some View {
        VStack {
            PressableView { pressed in
                shape
                    .fill(.red)
                    .frame(width: width, height: height)
                    .scaleEffect(pressed ? 1.2 : 1)
                    .animation(.spring().speed(4), value: pressed)
            }
            .onPressed(onPressed)
            .onReleased(onReleased)
            
            if label != nil {
                Text(label!)
                    .font(.footnote)
                    .foregroundColor(.white)
            }
        }
        .rotation3DEffect(Angle(degrees: -30), axis: (x: 0, y: 0, z: 1))
    }
}

struct DPadView: View {
    @EnvironmentObject private var buttons: Buttons
    
    var body: some View {
        VStack {
            GameButtonView(shape: Circle(), onPressed: { buttons.up = true  }, onReleased: { buttons.up = false })
                .offset(x: 0, y: 10)
            HStack(spacing: 40) {
                GameButtonView(shape: Circle(), onPressed: { buttons.left = true }, onReleased: { buttons.left = false })
                GameButtonView(shape: Circle(), onPressed: { buttons.right = true }, onReleased: { buttons.right = false })
            }
            GameButtonView(shape: Circle(), onPressed: { buttons.down = true }, onReleased: { buttons.down = false })
                .offset(x: 0, y: -10)
        }
    }
}

struct ABView: View {
    @EnvironmentObject private var buttons: Buttons
    
    var body: some View {
        HStack {
            GameButtonView(shape: Circle(), label: "B", onPressed: { buttons.b = true }, onReleased: { buttons.b = false })
                .offset(x: 0, y: 30)
            GameButtonView(shape: Circle(), label: "A", onPressed: { buttons.a = true }, onReleased: { buttons.a = false })
        }
    }
}

struct StartSelectView: View {
    @EnvironmentObject private var buttons: Buttons
    
    var body: some View {
        HStack {
            GameButtonView(
                shape: RoundedRectangle(cornerRadius: 5),
                label: "START",
                width: 45,
                height: 10,
                onPressed: { buttons.start = true },
                onReleased: { buttons.start = false }
            )
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            GameButtonView(
                shape: RoundedRectangle(cornerRadius: 5),
                label: "SELECT",
                width: 45,
                height: 10,
                onPressed: { buttons.select = true },
                onReleased: { buttons.select = false }
            )
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        }
    }
}

struct TitleView: View {
    var title: String
    var onReleased: () -> Void
    
    var body: some View {
        PressableView { pressed in
            Text(title)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .foregroundColor(pressed ? .black : .white)
                .padding(.vertical, 5)
                .background(Rectangle().fill(pressed ? .white : .white.opacity(0)))
        }
        .onReleased(onReleased)
    }
}

struct GameBoyView: View {
    private var lcd: LCDBitmapView
    @EnvironmentObject private var gameLibraryManager: GameLibraryManager
    
    init(lcd: LCDBitmapView) {
        self.lcd = lcd
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Group {
                    if geometry.size.width > geometry.size.height {
                        HStack {
                            VStack {
                                Spacer()
                                DPadView()
                                Spacer()
                            }
                            .padding(.trailing, 20)
                            .frame(width: geometry.size.width * 0.2)
                            lcd
                            VStack {
                                Spacer()
                                ABView()
                                Spacer()
                                StartSelectView()
                            }
                            .frame(width: geometry.size.width * 0.2)
                        }
                    } else {
                        VStack{
                            // TODO: возможно как-то избавиться от работы с опционалом
                            TitleView(title: gameLibraryManager.inserted?.title ?? "") {}
                            .padding(.top, 20)
                            lcd.frame(height: geometry.size.height * 0.5)
                            VStack {
                                Spacer()
                                HStack {
                                    DPadView()
                                    Spacer()
                                    ABView()
                                }
                                Spacer()
                                StartSelectView()
                            }
                            .padding()
                        }
                    }
                }
            }
            .background(.black)
        }
        .frame(width: .infinity, height: .infinity)
    }
}
