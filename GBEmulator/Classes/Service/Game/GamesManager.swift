//
//  GamesManager.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import RxSwift

protocol GamesManagerProtocol {
    func obtainGames(forceUpdate: Bool) -> Single<[Game]>
    func uploadGame(fileURL: URL) -> Single<URL?>
}

final class GamesManager {
    enum Constants {
        static let gamesCacheKey = "games_cache_key"
    }
    
    private lazy var restApiTransport = RestAPITransport()
}

// MARK: GamesManagerProtocol
extension GamesManager: GamesManagerProtocol {
    func obtainGames(forceUpdate: Bool) -> Single<[Game]> {
        forceUpdate ? fetchGames() : cachedGames()
    }
    
    func uploadGame(fileURL: URL) -> Single<URL?> {
        restApiTransport
            .formBody(fileUrl: fileURL, request: UploadGameRequest())
            .map { UploadGameResponse.url(from: $0) }
    }
}

// MARK: Private
private extension GamesManager {
    func cachedGames() -> Single<[Game]> {
        Single<[Game]>.create { single in
            let games: [Game] = {
                guard 
                    let data = UserDefaults.standard.data(forKey: Constants.gamesCacheKey),
                    let array = try? JSONDecoder().decode([Game].self, from: data)
                else {
                    return []
                }
                
                return array
            }()
            
            single(.success(games))
            
            return Disposables.create()
        }
    }
    
    func fetchGames() -> Single<[Game]> {
        restApiTransport
            .callServerApi(requestBody: GetGamesRequest())
            .map { Game.map(response: $0) }
            .do(onSuccess: { games in
                guard let data = try? JSONEncoder().encode(games) else {
                    return
                }
                
                UserDefaults.standard.set(data, forKey: Constants.gamesCacheKey)
            })
    }
}
