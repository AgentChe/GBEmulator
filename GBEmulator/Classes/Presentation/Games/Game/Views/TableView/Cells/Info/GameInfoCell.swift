//
//  GameInfoCell.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import UIKit

final class GameInfoCell: UITableViewCell {
    lazy var ratingView = makeRatingView()
    lazy var label = makeLabel()
    
    private lazy var nameAttrs = TextAttributes()
        .textColor(Appearance.mono100)
        .font(Fonts.Joystix.monospace(size: 24.scale))
        .lineHeight(33.6.scale)
        .textAlignment(.left)
    private lazy var sizeAttrs = TextAttributes()
        .textColor(Appearance.mono100.withAlphaComponent(0.5))
        .font(Fonts.RobotoMono.regular(size: 16.scale))
        .lineHeight(22.4.scale)
        .textAlignment(.left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension GameInfoCell {
    func setup(element: GameInfoElement) {
        ratingView.rating = element.rating
        
        let text = NSMutableAttributedString()
        text.append(element.name.attributed(with: nameAttrs))
        text.append(" ".attributed(with: sizeAttrs))
        text.append(element.size.attributed(with: sizeAttrs))
        label.attributedText = text
    }
}

// MARK: Private
private extension GameInfoCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension GameInfoCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            ratingView.widthAnchor.constraint(equalToConstant: 116.scale),
            ratingView.heightAnchor.constraint(equalToConstant: 25.scale),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            ratingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 57.scale),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension GameInfoCell {
    func makeRatingView() -> RatingView {
        let view = RatingView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
