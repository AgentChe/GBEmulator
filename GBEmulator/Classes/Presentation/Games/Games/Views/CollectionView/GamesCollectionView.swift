//
//  GamesCollectionView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class GamesCollectionView: UICollectionView {
    private lazy var elements = [Game]()
    
    private lazy var didSelectTrigger = PublishRelay<Game>()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension GamesCollectionView {
    func setup(elements: [Game]) {
        self.elements = elements
        
        reloadData()
    }
    
    var didSelect: Signal<Game> {
        didSelectTrigger.asSignal()
    }
}

// MARK: UICollectionViewDataSource
extension GamesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: GamesCollectionCell.self), for: indexPath) as! GamesCollectionCell
        cell.setup(game: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension GamesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectTrigger.accept(elements[indexPath.row])
    }
}

// MARK: Private
private extension GamesCollectionView {
    func initialize() {
        register(GamesCollectionCell.self, forCellWithReuseIdentifier: String(describing: GamesCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
