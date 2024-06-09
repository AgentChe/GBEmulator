//
//  GameCountriesCollectionView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import UIKit

final class GameCountriesCollectionView: UICollectionView {
    private lazy var elements = [Game.Country]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension GameCountriesCollectionView {
    func setup(elements: [Game.Country]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension GameCountriesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: GameCountryCell.self), for: indexPath) as! GameCountryCell
        cell.setup(country: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension GameCountriesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        GameCountryCell.size(for: elements[indexPath.row])
    }
}

// MARK: Private
private extension GameCountriesCollectionView {
    func initialize() {
        register(GameCountryCell.self, forCellWithReuseIdentifier: String(describing: GameCountryCell.self))
        
        dataSource = self
        delegate = self
    }
}
