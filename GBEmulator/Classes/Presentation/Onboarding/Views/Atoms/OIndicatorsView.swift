//
//  OIndicatorsView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 31.05.2024.
//

import UIKit

final class OIndicatorsView: UIView {
    lazy var page = 1 {
        didSet {
            update()
        }
    }
    
    lazy var indicator1 = makeIndicator()
    lazy var indicator2 = makeIndicator()
    lazy var indicator3 = makeIndicator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OIndicatorsView {
    func update() {
        let selected = UIImage(named: "Onboarding.Indicator.S")
        let deselected = UIImage(named: "Onboarding.Indicator.D")
        
        indicator1.image = page == 1 ? selected : deselected
        indicator2.image = page == 2 ? selected : deselected
        indicator3.image = page == 3 ? selected : deselected
    }
}

// MARK: Make constraints
private extension OIndicatorsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            indicator1.widthAnchor.constraint(equalToConstant: 12.scale),
            indicator1.leadingAnchor.constraint(equalTo: leadingAnchor),
            indicator1.topAnchor.constraint(equalTo: topAnchor),
            indicator1.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicator2.widthAnchor.constraint(equalToConstant: 12.scale),
            indicator2.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator2.topAnchor.constraint(equalTo: topAnchor),
            indicator2.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicator3.widthAnchor.constraint(equalToConstant: 12.scale),
            indicator3.trailingAnchor.constraint(equalTo: trailingAnchor),
            indicator3.topAnchor.constraint(equalTo: topAnchor),
            indicator3.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OIndicatorsView {
    func makeIndicator() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
