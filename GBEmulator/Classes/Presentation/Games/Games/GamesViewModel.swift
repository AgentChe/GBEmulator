//
//  GamesViewModel.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import RxSwift
import RxCocoa

final class GamesViewModel {
    enum Route {
        case dismiss
        case game(Game)
    }
    
    private lazy var activity = RxActivityIndicator()
    
    private lazy var gamesManager = GamesManager()
    
    private lazy var observableRetrySingle = ObservableRetrySingle()
}

// MARK: Public
extension GamesViewModel {
    struct Input {
        let didTapClose: Signal<Void>
        let didSearch: Signal<String>
        let didSelect: Signal<Game>
    }
    
    struct Output {
        let activity: Driver<Bool>
        let elements: Driver<[Game]>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        let games = makeGames()
        
        return Output(
            activity: activity.asDriver(),
            elements: makeElements(
                didSearch: input.didSearch,
                games: games
            ),
            route: makeRoute(
                didTapClose: input.didTapClose,
                didSelect: input.didSelect
            )
        )
    }
}

// MARK: Private
private extension GamesViewModel {
    func makeElements(
        didSearch: Signal<String>,
        games: Driver<[Game]>
    ) -> Driver<[Game]> {
        Driver
            .combineLatest(
                didSearch.asDriver(onErrorJustReturn: ""),
                games
            ) { filter, games -> [Game] in
                guard !filter.isEmpty else { return games }
                
                return games.filter { game -> Bool in
                    game.title.contains(filter)
                }
            }
    }
    
    func makeGames() -> Driver<[Game]> {
        gamesManager
            .obtainGames(forceUpdate: true)
            .trackActivity(activity)
            .asDriver(onErrorJustReturn: [])
    }
    
    func makeRoute(
        didTapClose: Signal<Void>,
        didSelect: Signal<Game>
    ) -> Driver<Route> {
        let dismiss = didTapClose
            .map { Route.dismiss }
            .asDriver(onErrorDriveWith: .never())
        
        let select = didSelect
            .map { Route.game($0) }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(dismiss, select)
    }
}
