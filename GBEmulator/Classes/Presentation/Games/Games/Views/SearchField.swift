//
//  SearchField.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import UIKit

final class SearchField: UIView {
    lazy var iconView = makeIconView()
    lazy var textField = makeTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UITextFieldDelegate
extension SearchField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Make constraints
private extension SearchField {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 16.scale),
            iconView.heightAnchor.constraint(equalToConstant: 16.scale),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33.scale),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.scale),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SearchField {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "Games.Search")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextField() -> UITextField {
        let placeholderAttrs = TextAttributes()
            .textColor(UIColor(integralRed: 60, green: 60, blue: 67, alpha: 0.6))
            .font(Fonts.RobotoMono.regular(size: 17.scale))
            .lineHeight(22.scale)
            .letterSpacing(-0.4.scale)
        let textAttrs = TextAttributes()
            .textColor(UIColor(integralRed: 60, green: 60, blue: 67))
            .font(Fonts.RobotoMono.regular(size: 17.scale))
            .lineHeight(22.scale)
            .letterSpacing(-0.4.scale)
        
        let view = UITextField()
        view.attributedPlaceholder = "Games.Search.Placeholder".localized.attributed(with: placeholderAttrs)
        view.defaultTextAttributes = textAttrs.dictionary
        view.backgroundColor = UIColor.clear
        view.borderStyle = .none
        view.returnKeyType = .done
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
