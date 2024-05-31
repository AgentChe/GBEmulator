//
//  PaygateView.swift
//  CodeChallenge
//
//  Created by Андрей Чернышев on 20.02.2024.
//

import UIKit

final class PaygateView: UIView {
    lazy var imageView = makeImageView()
    lazy var closeButton = makeCloseButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var cell1 = makeCell(number: 1)
    lazy var cell2 = makeCell(number: 2)
    lazy var cell3 = makeCell(number: 3)
    lazy var product1Button = makeProductButton()
    lazy var product2Button = makeProductButton()
    lazy var bestOfferView = makeBestOfferView()
    lazy var enableTrialButton = makeEnableTrialButton()
    lazy var buyButton = makeBuyButton()
    lazy var infoView = makeInfoView()
    lazy var actionsView = makeActionsView()
    lazy var preloader = makePreloader()
    
    private lazy var buyAttrs = TextAttributes()
        .textColor(Appearance.mono100)
        .font(Fonts.Joystix.monospace(size: 16.scale))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PaygateView {
    func setup(buyTitle: String) {
        buyButton.setAttributedTitle(buyTitle.attributed(with: buyAttrs), for: .normal)
    }
}

// MARK: Private
private extension PaygateView {
    func initialize() {
        backgroundColor = Appearance.main100
    }
}

// MARK: Make constraints
private extension PaygateView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 218.scale : 173.scale),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 152.scale : 121.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 55.scale : 35.scale)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 24.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 68.scale : 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell1.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell1.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell2.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell2.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell2.topAnchor.constraint(equalTo: cell1.bottomAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell3.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell3.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell3.topAnchor.constraint(equalTo: cell2.bottomAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            enableTrialButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            enableTrialButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            enableTrialButton.topAnchor.constraint(equalTo: cell3.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 12.scale),
            enableTrialButton.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 63.scale : 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            product1Button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            product1Button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.scale),
            product1Button.topAnchor.constraint(equalTo: enableTrialButton.bottomAnchor, constant: 16.scale),
            product1Button.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 76.scale : 68.scale)
        ])
        
        NSLayoutConstraint.activate([
            product2Button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            product2Button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.scale),
            product2Button.topAnchor.constraint(equalTo: product1Button.bottomAnchor, constant: 16.scale),
            product2Button.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 76.scale : 68.scale)
        ])
        
        NSLayoutConstraint.activate([
            bestOfferView.centerYAnchor.constraint(equalTo: product1Button.topAnchor),
            bestOfferView.trailingAnchor.constraint(equalTo: product1Button.trailingAnchor, constant: -9.scale)
        ])
        
        NSLayoutConstraint.activate([
            buyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            buyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            buyButton.topAnchor.constraint(equalTo: product2Button.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 12.scale),
            buyButton.heightAnchor.constraint(equalToConstant: 54.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoView.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            actionsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16.scale),
            actionsView.heightAnchor.constraint(equalToConstant: 17.scale)
        ])
        
        NSLayoutConstraint.activate([
            preloader.widthAnchor.constraint(equalToConstant: 45.scale),
            preloader.heightAnchor.constraint(equalToConstant: 45.scale),
            preloader.centerXAnchor.constraint(equalTo: centerXAnchor),
            preloader.centerYAnchor.constraint(equalTo: buyButton.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: ScreenSize.isIphoneXFamily ? "Paygate.Image.X" : "Paygate.Image.8")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCloseButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Paygate.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono100)
            .font(Fonts.Joystix.monospace(size: ScreenSize.isIphoneXFamily ? 24.scale : 22.scale))
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 2
        view.attributedText = "Paygate.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell(number: Int) -> PaygateInfoCell {
        let view = PaygateInfoCell(text: "Paygate.Info\(number)".localized)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeEnableTrialButton() -> PaygateEnableTrialButton {
        let view = PaygateEnableTrialButton()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeProductButton() -> PaygateProductButton {
        let view = PaygateProductButton()
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBestOfferView() -> PaygateBestOfferView {
        let view = PaygateBestOfferView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBuyButton() -> UIButton {
        let view = UIButton()
        view.layer.cornerRadius = 12.scale
        view.layer.shadowColor = UIColor(displayP3Red: 0.247, green: 0.502, blue: 0.196, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 12.scale)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 0
        view.backgroundColor = Appearance.main400
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeInfoView() -> PaygateInfoView {
        let view = PaygateInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeActionsView() -> PaygateActionsView {
        let view = PaygateActionsView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePreloader() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = Appearance.main400
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
