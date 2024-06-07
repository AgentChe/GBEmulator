//
//  EmulatorOptionButton.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit

final class EmulatorOptionButton: UIButton {
    lazy var label = makeLabel()
    lazy var circleView = makeCircleView()
    
    let title: String
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension EmulatorOptionButton {
    func initialize() {
        backgroundColor = Appearance.main200
        layer.cornerRadius = 11.5.scale
        layer.masksToBounds = true
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
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
private extension EmulatorOptionButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25.scale),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 19.scale),
            circleView.heightAnchor.constraint(equalToConstant: 19.scale),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension EmulatorOptionButton {
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono100)
            .font(Fonts.Joystix.monospace(size: 12.scale))
            .lineHeight(16.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = title.localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCircleView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "Emulator.Circle")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
