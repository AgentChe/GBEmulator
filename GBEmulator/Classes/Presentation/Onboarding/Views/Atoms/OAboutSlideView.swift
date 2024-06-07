//
//  OAboutSlideView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 31.05.2024.
//

import UIKit

final class OAboutSlideView: UIView {
    lazy var imageView = makeImageView(name: "Onboarding.About\(number).Image")
    lazy var titleView = makeImageView(name: "Onboarding.About\(number).Title")
    lazy var textLabel = makeTextLabel()
    
    private let number: Int
    
    init(number: Int) {
        self.number = number
        
        super.init(frame: .zero)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension OAboutSlideView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 300.scale),
            imageView.heightAnchor.constraint(equalToConstant: 300.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 94.scale : 50.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleView.widthAnchor.constraint(equalToConstant: 358.scale),
            titleView.heightAnchor.constraint(equalToConstant: number == 3 ? 95.scale : 66.scale),
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            textLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OAboutSlideView {
    func makeImageView(name: String) -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: name)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono100)
            .font(Fonts.RobotoMono.regular(size: 16.scale))
            .lineHeight(22.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.About\(number).Text".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
