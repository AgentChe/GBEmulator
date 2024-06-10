//
//  GameViewModel.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import RxSwift
import RxCocoa

final class GameViewModel {
    enum Route {
        case dismiss
        case play(Game)
        case paygate
    }
    
    private let game: Driver<Game>
    
    init(game: Game) {
        self.game = BehaviorRelay(value: game).asDriver()
    }
}

// MARK: Public
extension GameViewModel {
    struct Input {
        let didTapClose: Signal<Void>
        let didTapPlay: Signal<Void>
    }
    
    struct Output {
        let route: Driver<Route>
        let elements: Driver<[GameTableElement]>
    }
    
    func configure(input: Input) -> Output {
        Output(
            route: makeRoute(
                didTapClose: input.didTapClose,
                didTapPlay: input.didTapPlay
            ),
            elements: makeElements()
        )
    }
}

// MARK: Private
private extension GameViewModel {
    func makeRoute(
        didTapClose: Signal<Void>,
        didTapPlay: Signal<Void>
    ) -> Driver<Route> {
        let dismiss = didTapClose
            .map { Route.dismiss }
            .asDriver(onErrorDriveWith: .never())
        
        let playOrPaygate = didTapPlay
            .asDriver(onErrorDriveWith: .never())
            .withLatestFrom(game)
            .map { game -> Route in
                let needPayment = game.paid ? !SessionManager().hasActiveSubscriptions() : false
                return needPayment ? .paygate : .play(game)
            }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(dismiss, playOrPaygate)
    }
    
    func makeElements() -> Driver<[GameTableElement]> {
        game
            .map { game -> [GameTableElement] in
                var result: [GameTableElement] = [.image(game.thumbnail)]
                
                let info = GameInfoElement(
                    rating: game.rating.value,
                    name: game.title,
                    size: game.size
                )
                result.append(.info(info))
                
                if !game.countries.isEmpty {
                    result.append(.countries(game.countries))
                }
                
                if let description = game.description {
                    result.append(.description(description))
                }
                
                return result
            }
    }
}
