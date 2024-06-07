//
//  EmulatorLRButton.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit

final class EmulatorLRButton: UIButton {
    lazy var backgroundView = makeBackgroundView()
    lazy var label = makeLabel()
    
    private let key: String
    
    init(key: String) {
        self.key = key
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension EmulatorLRButton {
    func initialize() {
        backgroundColor = UIColor.clear
        
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
private extension EmulatorLRButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension EmulatorLRButton {
    func makeBackgroundView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: key)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .font(Fonts.Joystix.monospace(size: 16.scale))
            .textColor(UIColor(integralRed: 160, green: 160, blue: 160))
        
        let view = UILabel()
        view.attributedText = key.localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
