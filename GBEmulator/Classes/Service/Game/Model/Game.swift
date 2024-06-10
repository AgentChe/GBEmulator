//
//  Game.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import Foundation

struct Game: Codable {
    let title: String
    let thumbnail: URL
    let rating: Rating
    let size: String
    let countries: [Country]
    let description: String?
    let source: URL
    let paid: Bool
    
    init?(json: [String: Any]) {
        guard
            let title = json["title"] as? String,
            let imagePath = json["thumbnail"] as? String,
            let imageFullPath = (GlobalDefinitions.emulatorDomain + "/" + imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let thumbnail = URL(string: imageFullPath),
            let ratingJSON = json["rating"] as? [String: Any],
            let rating = Rating(json: ratingJSON),
            let size = json["game_size"] as? String,
            let sourcePath = json["game_src"] as? String,
            let sourceFullPath = (GlobalDefinitions.emulatorDomain + "/" + sourcePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let source = URL(string: sourceFullPath)
        else {
            return nil
        }
        
        self.title = title
        self.thumbnail = thumbnail
        self.rating = rating
        self.size = size
        self.countries = {
            guard let array = json["countries"] as? [[String: Any]] else {
                return []
            }
            
            return array.compactMap { Country(json: $0) }
        }()
        self.description = json["description"] as? String
        self.source = source
        self.paid = json["is_paid"] as? Bool ?? false
    }
}

// MARK: Additional (Rating)
extension Game {
    struct Rating: Codable {
        let value: Float
        let count: String
        
        init?(json: [String: Any]) {
            guard
                let valueString = json["value"] as? String,
                let value = Float(valueString),
                let count = json["count"] as? String
            else {
                return nil
            }
            
            self.value = value
            self.count = count
        }
    }
}

// MARK: Additional (Country)
extension Game {
    struct Country: Codable {
        let name: String
        let flag: URL
        
        init?(json: [String: Any]) {
            guard
                let country = json["country"] as? String,
                let flagPath = json["flag"] as? String,
                let flagUrl = URL(string: flagPath)
            else {
                return nil
            }
            
            self.name = country
            self.flag = flagUrl
        }
    }
}

// MARK: Public
extension Game {
    static func map(response: Any) -> [Game] {
        guard let array = response as? [[String: Any]] else {
            return []
        }
        
        return array.compactMap { json -> Game? in
            Game(json: json)
        }
    }
}
