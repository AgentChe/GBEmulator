//
//  OCategoriesView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 31.05.2024.
//

import UIKit

final class OCategoriesView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var scrollView = makeScrollView()
    lazy var actionButton = makeCategoryButton(key: "Action")
    lazy var adventureButton = makeCategoryButton(key: "Adventure")
    lazy var puzzleButton = makeCategoryButton(key: "Puzzle")
    lazy var interactiveFictionButton = makeCategoryButton(key: "InteractiveFiction")
    lazy var rpgButton = makeCategoryButton(key: "RPG")
    lazy var survivalButton = makeCategoryButton(key: "Survival")
    lazy var continueButton = makeContinueButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OCategoriesView {
    func initialize() {
        backgroundColor = Appearance.main100
    }
    
    @objc
    func tapped(sender: UIButton) {
        guard let categoryButton = sender as? OCategoryButton else {
            return
        }
        
        categoryButton.marked.toggle()
    }
}

// MARK: Make constraints
private extension OCategoriesView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 87.scale : 40.scale)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.scale),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -2.scale)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            actionButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            actionButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            actionButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24.scale),
            actionButton.heightAnchor.constraint(equalToConstant: 64.scale)
        ])
        
        NSLayoutConstraint.activate([
            adventureButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            adventureButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            adventureButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 16.scale),
            adventureButton.heightAnchor.constraint(equalToConstant: 64.scale)
        ])
        
        NSLayoutConstraint.activate([
            puzzleButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            puzzleButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            puzzleButton.topAnchor.constraint(equalTo: adventureButton.bottomAnchor, constant: 16.scale),
            puzzleButton.heightAnchor.constraint(equalToConstant: 64.scale)
        ])
        
        NSLayoutConstraint.activate([
            interactiveFictionButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            interactiveFictionButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            interactiveFictionButton.topAnchor.constraint(equalTo: puzzleButton.bottomAnchor, constant: 16.scale),
            interactiveFictionButton.heightAnchor.constraint(equalToConstant: 64.scale)
        ])
        
        NSLayoutConstraint.activate([
            rpgButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            rpgButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            rpgButton.topAnchor.constraint(equalTo: interactiveFictionButton.bottomAnchor, constant: 16.scale),
            rpgButton.heightAnchor.constraint(equalToConstant: 64.scale)
        ])
        
        NSLayoutConstraint.activate([
            survivalButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            survivalButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            survivalButton.topAnchor.constraint(equalTo: rpgButton.bottomAnchor, constant: 16.scale),
            survivalButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.scale),
            survivalButton.heightAnchor.constraint(equalToConstant: 64.scale)
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
private extension OCategoriesView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono100)
            .font(Fonts.Joystix.monospace(size: 18.scale))
            .lineHeight(25.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Category.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets()
        view.setContentOffset(CGPoint.zero, animated: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCategoryButton(key: String) -> OCategoryButton {
        let view = OCategoryButton(key: key)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        scrollView.addSubview(view)
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
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
