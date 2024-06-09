//
//  GamesCollectionCell.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import UIKit
import Kingfisher

final class GamesCollectionCell: UICollectionViewCell {
    lazy var cartridgeView = makeCartridgeView()
    lazy var imageView = makeImageView()
    lazy var nameLabel = makeLabel()
    
    private lazy var attrs = TextAttributes()
        .textColor(Appearance.mono100)
        .font(Fonts.Joystix.monospace(size: 16.scale))
        .lineHeight(22.4.scale)
        .textAlignment(.left)
        .lineBreakMode(.byTruncatingTail)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
}

// MARK: Public
extension GamesCollectionCell {
    func setup(game: Game) {
        imageView.kf.setImage(with: game.thumbnail)
        nameLabel.attributedText = game.title.attributed(with: attrs)
    }
}

// MARK: Private
private extension GamesCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension GamesCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            cartridgeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cartridgeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartridgeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cartridgeView.heightAnchor.constraint(equalToConstant: 144.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 112.scale),
            imageView.heightAnchor.constraint(equalToConstant: 78.scale),
            imageView.centerXAnchor.constraint(equalTo: cartridgeView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: cartridgeView.topAnchor, constant: 49.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: cartridgeView.bottomAnchor, constant: 8.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension GamesCollectionCell {
    func makeCartridgeView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "Games.Cartridge")
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
