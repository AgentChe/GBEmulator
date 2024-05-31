//
//  OCategoryButton.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 31.05.2024.
//

import UIKit

final class OCategoryButton: UIButton {
    lazy var marked = false {
        didSet {
            update()
        }
    }
    
    lazy var iconView = makeIconView()
    lazy var label = makeLabel()
    lazy var markerView = makeMarkerView()
    
    private lazy var dotterLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = Appearance.main300.cgColor
        shapeLayer.lineWidth = 2.scale
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [NSNumber(value: 6.scale), NSNumber(value: 3.scale)]
        layer.addSublayer(shapeLayer)
        return shapeLayer
    }()
    
    private let key: String
    
    init(key: String) {
        self.key = key
        
        super.init(frame: .zero)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dotterLayer.bounds = bounds
        dotterLayer.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let path = UIBezierPath(rect: bounds)
        dotterLayer.path = path.cgPath
    }
}

// MARK: Private
private extension OCategoryButton {
    func update() {
        dotterLayer.strokeColor = marked ? Appearance.main600.cgColor : Appearance.main300.cgColor
        
        let markerName = marked ? "Onboarding.Category.S" : "Onboarding.Category.D"
        markerView.image = UIImage(named: markerName)
    }
}

// MARK: Make constraints
private extension OCategoryButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 40.scale),
            iconView.heightAnchor.constraint(equalToConstant: 40.scale),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56.scale),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 21.scale),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -21.scale)
        ])
        
        NSLayoutConstraint.activate([
            markerView.widthAnchor.constraint(equalToConstant: 24.scale),
            markerView.heightAnchor.constraint(equalToConstant: 24.scale),
            markerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            markerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OCategoryButton {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "Onboarding.Category.\(key)")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono100)
            .font(Fonts.Joystix.monospace(size: 16.scale))
            .lineHeight(22.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Category.\(key)".localized.uppercased().attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeMarkerView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
