//
//  GameTableView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import UIKit

final class GameTableView: UITableView {
    private lazy var elements = [GameTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension GameTableView {
    func setup(elements: [GameTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension GameTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .image(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: GameImageCell.self), for: indexPath) as! GameImageCell
            cell.setup(element: element)
            return cell
        case .info(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: GameInfoCell.self), for: indexPath) as! GameInfoCell
            cell.setup(element: element)
            return cell
        case .countries(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: GameCountriesCell.self), for: indexPath) as! GameCountriesCell
            cell.setup(element: element)
            return cell
        case .description(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: GameDescriptionCell.self), for: indexPath) as! GameDescriptionCell
            cell.setup(element: element)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension GameTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: Private
private extension GameTableView {
    func initialize() {
        register(GameImageCell.self, forCellReuseIdentifier: String(describing: GameImageCell.self))
        register(GameInfoCell.self, forCellReuseIdentifier: String(describing: GameInfoCell.self))
        register(GameCountriesCell.self, forCellReuseIdentifier: String(describing: GameCountriesCell.self))
        register(GameDescriptionCell.self, forCellReuseIdentifier: String(describing: GameDescriptionCell.self))
        
        dataSource = self
        delegate = self 
    }
}
