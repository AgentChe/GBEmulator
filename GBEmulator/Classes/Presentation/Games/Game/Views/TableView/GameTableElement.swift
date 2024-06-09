//
//  GameTableElement.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import Foundation

enum GameTableElement {
    case image(URL)
    case info(GameInfoElement)
    case countries([Game.Country])
    case description(String)
}

struct GameInfoElement {
    let rating: Float
    let name: String
    let size: String
}
