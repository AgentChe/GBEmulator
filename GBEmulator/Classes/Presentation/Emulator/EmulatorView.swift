//
//  EmulatorView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit

final class EmulatorView: UIView {
    lazy var lButton = makeLRButton(key: "Emulator.L")
    lazy var dPadView = makeDPadView()
    lazy var startButton = makeOptionButton(title: "Emulator.Start")
    lazy var selectButton = makeOptionButton(title: "Emulator.Select")
    lazy var bitmapView = makeBitmapView()
    lazy var rButton = makeLRButton(key: "Emulator.R")
    lazy var aButton = makeABButton(title: "Emulator.A".localized)
    lazy var bButton = makeABButton(title: "Emulator.B".localized)
    lazy var exitButton = makeOptionButton(title: "Emulator.Exit".localized)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension EmulatorView {
    func initialize() {
        backgroundColor = Appearance.main100
        
        let degrees: CGFloat = 15
        let radians = degrees * .pi / 180
        startButton.transform = CGAffineTransform(rotationAngle: radians)
        selectButton.transform = CGAffineTransform(rotationAngle: radians)
    }
}

// MARK: Make constraints
private extension EmulatorView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            lButton.widthAnchor.constraint(equalToConstant: 103.scale),
            lButton.heightAnchor.constraint(equalToConstant: 44.scale),
            lButton.topAnchor.constraint(equalTo: topAnchor, constant: 21.scale),
            lButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 53.scale)
        ])
        
        NSLayoutConstraint.activate([
            dPadView.widthAnchor.constraint(equalToConstant: 132.scale),
            dPadView.heightAnchor.constraint(equalToConstant: 132.scale),
            dPadView.trailingAnchor.constraint(equalTo: bitmapView.leadingAnchor, constant: -30.scale),
            dPadView.topAnchor.constraint(equalTo: lButton.bottomAnchor, constant: 37.scale)
        ])
        
        NSLayoutConstraint.activate([
            startButton.trailingAnchor.constraint(equalTo: bitmapView.leadingAnchor, constant: -30.scale),
            startButton.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -16.scale),
            startButton.heightAnchor.constraint(equalToConstant: 23.scale)
        ])
        
        NSLayoutConstraint.activate([
            selectButton.trailingAnchor.constraint(equalTo: bitmapView.leadingAnchor, constant: -30.scale),
            selectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28.scale),
            selectButton.heightAnchor.constraint(equalToConstant: 23.scale)
        ])
        
        NSLayoutConstraint.activate([
            bitmapView.widthAnchor.constraint(equalToConstant: 390.scale),
            bitmapView.heightAnchor.constraint(equalToConstant: 348.scale),
            bitmapView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bitmapView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rButton.widthAnchor.constraint(equalToConstant: 103.scale),
            rButton.heightAnchor.constraint(equalToConstant: 44.scale),
            rButton.topAnchor.constraint(equalTo: topAnchor, constant: 21.scale),
            rButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -53.scale)
        ])
        
        NSLayoutConstraint.activate([
            aButton.widthAnchor.constraint(equalToConstant: 52.scale),
            aButton.heightAnchor.constraint(equalToConstant: 52.scale),
            aButton.leadingAnchor.constraint(equalTo: bitmapView.trailingAnchor, constant: 88.scale),
            aButton.topAnchor.constraint(equalTo: rButton.bottomAnchor, constant: 61.scale)
        ])
        
        NSLayoutConstraint.activate([
            bButton.widthAnchor.constraint(equalToConstant: 52.scale),
            bButton.heightAnchor.constraint(equalToConstant: 52.scale),
            bButton.leadingAnchor.constraint(equalTo: bitmapView.trailingAnchor, constant: 30.scale),
            bButton.topAnchor.constraint(equalTo: rButton.bottomAnchor, constant: 95.scale)
        ])
        
        NSLayoutConstraint.activate([
            exitButton.leadingAnchor.constraint(equalTo: bitmapView.trailingAnchor, constant: 30.scale),
            exitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28.scale),
            exitButton.heightAnchor.constraint(equalToConstant: 23.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension EmulatorView {
    func makeLRButton(key: String) -> EmulatorLRButton {
        let view = EmulatorLRButton(key: key)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDPadView() -> EmulatorDPadView {
        let view = EmulatorDPadView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeOptionButton(title: String) -> EmulatorOptionButton {
        let view = EmulatorOptionButton(title: title)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBitmapView() -> LCDBitmap {
        let view = LCDBitmap()
        view.backgroundColor = UIColor(integralRed: 78, green: 105, blue: 73)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeABButton(title: String) -> EmulatorABButton {
        let view = EmulatorABButton(title: title)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
