//
//  EmulatorDPadButton.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit

final class EmulatorDPadButton: UIButton {
    enum Direction {
        case left, right, up, down
    }
    
    enum Constants {
        static let margin = CGFloat(5)
        static let width = CGFloat(11)
        static let height = CGFloat(14)
    }
    
    private lazy var shapeLayer = CAShapeLayer()
    
    private let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
        
        super.init(frame: .zero)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath()
        
        switch direction {
        case .left:
            path.move(to: CGPoint(
                x: bounds.width - Constants.margin - Constants.width,
                y: bounds.height / 2
            ))
            path.addLine(to: CGPoint(
                x: bounds.width - Constants.margin,
                y: bounds.height / 2 - (Constants.height / 2)
            ))
            path.addLine(to: CGPoint(
                x: bounds.width - Constants.margin,
                y: bounds.height / 2 + (Constants.height / 2)
            ))
        case .right:
            path.move(to: CGPoint(
                x: Constants.margin,
                y: bounds.height / 2 - (Constants.height / 2)
            ))
            path.addLine(to: CGPoint(
                x: Constants.margin + Constants.width,
                y: bounds.height / 2
            ))
            path.addLine(to: CGPoint(
                x: Constants.margin,
                y: bounds.height / 2 + (Constants.height / 2)
            ))
        case .up:
            path.move(to: CGPoint(
                x: bounds.width / 2 - Constants.height / 2,
                y: bounds.height - Constants.margin
            ))
            path.addLine(to: CGPoint(
                x: bounds.width / 2,
                y: bounds.height - Constants.margin - Constants.width
            ))
            path.addLine(to: CGPoint(
                x: bounds.width / 2 + Constants.width / 2,
                y: bounds.height - Constants.margin
            ))
        case .down:
            path.move(to: CGPoint(
                x: bounds.width / 2 - Constants.height / 2,
                y: Constants.margin
            ))
            path.addLine(to: CGPoint(
                x: bounds.width / 2 + Constants.height / 2,
                y: Constants.margin
            ))
            path.addLine(to: CGPoint(
                x: bounds.width / 2,
                y: Constants.margin + Constants.width
            ))
        }
        
        path.close()
        
        shapeLayer.path = path.cgPath
    }
}

// MARK: Private
private extension EmulatorDPadButton {
    func initialize() {
        backgroundColor = UIColor(integralRed: 116, green: 117, blue: 116)
        
        switch direction {
        case .left:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .right:
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .up:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .down:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        layer.cornerRadius = 8.scale
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        
        shapeLayer.fillColor = Appearance.main300.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    @objc
    func touchDown() {
        alpha = 0.8
    }
    
    @objc
    func touchUpInside() {
        alpha = 1
    }
    
    @objc
    func touchDragExit() {
        alpha = 1
    }
}

// MARK: Make constraints
private extension EmulatorDPadButton {
    
}

// MARK: Lazy initialization
private extension EmulatorDPadButton {
    
}
