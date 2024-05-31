//
//  OAboutView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 31.05.2024.
//

import UIKit

final class OAboutView: OSlideView {
    lazy var slide1View = makeSlideView(key: "About1")
    lazy var slide2View = makeSlideView(key: "About2")
    lazy var indicatorsView = makeIndicatorsView()
    lazy var continueButton = makeContinueButton()
    
    private lazy var slide1LeadingConstraint = NSLayoutConstraint()
    private lazy var slide2LeadingConstraint = NSLayoutConstraint()
    
    private lazy var currentSlideNumber = 1 {
        didSet {
            indicatorsView.page = currentSlideNumber
        }
    }
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        RequestReview.request()
    }
}

// MARK: Private
private extension OAboutView {
    @objc
    func continueTapped() {
        if currentSlideNumber == 1 {
            NSLayoutConstraint.deactivate([
                slide1LeadingConstraint,
                slide2LeadingConstraint
            ])
            
            slide1LeadingConstraint.constant = -390.scale
            slide2LeadingConstraint.constant = 0
            
            NSLayoutConstraint.activate([
                slide1LeadingConstraint,
                slide2LeadingConstraint
            ])
            
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.layoutIfNeeded()
            }, completion: { [weak self] result in
                self?.currentSlideNumber = 2
            })
        } else {
            onNext()
        }
    }
}

// MARK: Make constraints
private extension OAboutView {
    func makeConstraints() {
        slide1LeadingConstraint = slide1View.leadingAnchor.constraint(equalTo: leadingAnchor)
        NSLayoutConstraint.activate([
            slide1LeadingConstraint,
            slide1View.topAnchor.constraint(equalTo: topAnchor),
            slide1View.bottomAnchor.constraint(equalTo: bottomAnchor),
            slide1View.widthAnchor.constraint(equalToConstant: 390.scale)
        ])
        
        slide2LeadingConstraint = slide2View.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 390.scale)
        NSLayoutConstraint.activate([
            slide2LeadingConstraint,
            slide2View.topAnchor.constraint(equalTo: topAnchor),
            slide2View.bottomAnchor.constraint(equalTo: bottomAnchor),
            slide2View.widthAnchor.constraint(equalToConstant: 390.scale)
        ])
        
        NSLayoutConstraint.activate([
            indicatorsView.widthAnchor.constraint(equalToConstant: 30.scale),
            indicatorsView.heightAnchor.constraint(equalToConstant: 12.scale),
            indicatorsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorsView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: ScreenSize.isIphoneXFamily ? -63.scale : -30.scale)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            continueButton.heightAnchor.constraint(equalToConstant: 54.scale),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OAboutView {
    func makeSlideView(key: String) -> OAboutSlideView {
        let view = OAboutSlideView(key: key)
        view.backgroundColor = Appearance.main100
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeIndicatorsView() -> OIndicatorsView {
        let view = OIndicatorsView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.mono100)
            .font(Fonts.Joystix.monospace(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Continue".localized.uppercased().attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 12.scale
        view.layer.shadowColor = UIColor(displayP3Red: 0.247, green: 0.502, blue: 0.196, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 12.scale)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 0
        view.backgroundColor = Appearance.main400
        view.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
