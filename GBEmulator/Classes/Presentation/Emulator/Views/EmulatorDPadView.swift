//
//  EmulatorDPadView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit

final class EmulatorDPadView: UIView {
    lazy var centerRect = makeCenterRect()
    lazy var circleView = makeCircleView()
    lazy var leftButton = makeButton(direction: .left)
    lazy var rightButton = makeButton(direction: .right)
    lazy var upButton = makeButton(direction: .up)
    lazy var downButton = makeButton(direction: .down)
    
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
private extension EmulatorDPadView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension EmulatorDPadView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            centerRect.widthAnchor.constraint(equalToConstant: 50.scale),
            centerRect.heightAnchor.constraint(equalToConstant: 50.scale),
            centerRect.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerRect.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 44.scale),
            circleView.heightAnchor.constraint(equalToConstant: 44.scale),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            leftButton.widthAnchor.constraint(equalToConstant: 41.scale),
            leftButton.heightAnchor.constraint(equalToConstant: 50.scale),
            leftButton.trailingAnchor.constraint(equalTo: centerRect.leadingAnchor),
            leftButton.centerYAnchor.constraint(equalTo: centerRect.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rightButton.widthAnchor.constraint(equalToConstant: 41.scale),
            rightButton.heightAnchor.constraint(equalToConstant: 50.scale),
            rightButton.leadingAnchor.constraint(equalTo: centerRect.trailingAnchor),
            rightButton.centerYAnchor.constraint(equalTo: centerRect.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            upButton.widthAnchor.constraint(equalToConstant: 50.scale),
            upButton.heightAnchor.constraint(equalToConstant: 41.scale),
            upButton.centerXAnchor.constraint(equalTo: centerRect.centerXAnchor),
            upButton.bottomAnchor.constraint(equalTo: centerRect.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            downButton.widthAnchor.constraint(equalToConstant: 50.scale),
            downButton.heightAnchor.constraint(equalToConstant: 41.scale),
            downButton.centerXAnchor.constraint(equalTo: centerRect.centerXAnchor),
            downButton.topAnchor.constraint(equalTo: centerRect.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension EmulatorDPadView {
    func makeCenterRect() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 116, green: 117, blue: 116)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCircleView() -> GradientView {
        let view = GradientView()
        view.gradientLayer.colors = [
            UIColor(integralRed: 75, green: 75, blue: 75).cgColor,
            UIColor(integralRed: 130, green: 132, blue: 130).cgColor
        ]
        view.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.cornerRadius = 22.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton(direction: EmulatorDPadButton.Direction) -> EmulatorDPadButton {
        let view = EmulatorDPadButton(direction: direction)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
