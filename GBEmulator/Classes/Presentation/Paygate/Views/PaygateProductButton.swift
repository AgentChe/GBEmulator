//
//  PaygateProductButton.swift
//  CodeChallenge
//
//  Created by Андрей Чернышев on 19.03.2024.
//

import UIKit
import RxCocoa

final class PaygateProductButton: UIButton {
    var marked: Bool = false {
        didSet {
            update()
        }
    }
    
    var product: ProductPrice? {
        didSet {
            update()
        }
    }
    
    lazy var leftLabel = makeLabel()
    lazy var rigthLabel = makeLabel()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
private extension PaygateProductButton {
    func update() {
        updateLeft()
        updateRight()
        updateMarker()
    }
    
    func updateLeft() {
        guard let product else {
            return
        }
        
        let isYearly = isYearly()
        
        let result = NSMutableAttributedString()
        
        switch isYearly {
        case true:
            let nameAttrs = TextAttributes()
                .textColor(Appearance.mono100)
                .font(Fonts.RobotoMono.regular(size: ScreenSize.isIphoneXFamily ? 16.scale : 15.scale))
                .lineHeight(ScreenSize.isIphoneXFamily ? 22.4.scale : 21.scale)
            let name = "Paygate.Yearly".localized + "\n"
            result.append(name.attributed(with: nameAttrs))
            
            let bottomAttrs = TextAttributes()
                .textColor(Appearance.mono100)
                .font(Fonts.RobotoMono.bold(size: 16.scale))
                .lineHeight(25.2.scale)
            let price = Currency(productPrice: product).formatted() ?? ""
            let bottom = String(format: "Paygate.Yearly.Bottom".localized, price)
            result.append(bottom.attributed(with: bottomAttrs))
        case false:
            let attrs = TextAttributes()
                .textColor(Appearance.mono100)
                .font(Fonts.RobotoMono.bold(size: ScreenSize.isIphoneXFamily ? 16.scale : 15.scale))
                .lineHeight(ScreenSize.isIphoneXFamily ? 22.4.scale : 21.scale)
            result.append("Paygate.FreeTrialDays".localized.uppercased().attributed(with: attrs))
        }
        
        leftLabel.attributedText = result
    }
    
    func updateRight() {
        guard let product else {
            return
        }
        
        let isYearly = isYearly()
        
        let result = NSMutableAttributedString()
        
        switch isYearly {
        case true:
            let priceAttrs = TextAttributes()
                .textColor(Appearance.mono100)
                .font(Fonts.RobotoMono.regular(size: 14.scale))
                .lineHeight(25.2.scale)
            let price = Currency(productPrice: product, div: 52).formatted() ?? ""
            result.append((price + "\n").attributed(with: priceAttrs))
            
            let periodAttrs = TextAttributes()
                .textColor(Appearance.mono100)
                .font(Fonts.RobotoMono.regular(size: ScreenSize.isIphoneXFamily ? 14.scale : 14.scale))
                .lineHeight(ScreenSize.isIphoneXFamily ? 22.4.scale : 22.4.scale)
            result.append("Paygate.PerWeek".localized.attributed(with: periodAttrs))
        case false:
            let priceAttrs = TextAttributes()
                .textColor(Appearance.mono100)
                .font(Fonts.RobotoMono.bold(size: 16.scale))
                .lineHeight(25.2.scale)
            let price = Currency(productPrice: product).formatted() ?? ""
            result.append(String(format: "Paygate.Then".localized, price).attributed(with: priceAttrs))
            
            let periodAttrs = TextAttributes()
                .textColor(Appearance.mono100)
                .font(Fonts.RobotoMono.regular(size: ScreenSize.isIphoneXFamily ? 14.scale : 14.scale))
                .lineHeight(ScreenSize.isIphoneXFamily ? 22.4.scale : 22.4.scale)
            result.append("Paygate.PerWeek".localized.attributed(with: periodAttrs))
        }
        
        rigthLabel.attributedText = result
    }
    
    func isYearly() -> Bool {
       product?.id == GlobalDefinitions.Paygate.yearly
    }
    
    func updateMarker() {
        let imageName = marked ? "Paygate.Marker.S" : "Paygate.Marker.D"
        markerView.image = UIImage(named: imageName)
        
        backgroundColor = marked ? Appearance.main400.withAlphaComponent(0.15) : UIColor.clear
        
        dotterLayer.strokeColor = marked ? Appearance.main400.cgColor : Appearance.main300.cgColor
    }
}

// MARK: Make constraints
private extension PaygateProductButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            leftLabel.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 178.scale : 162.scale),
            leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rigthLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 8.scale),
            rigthLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
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
private extension PaygateProductButton {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 2
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
