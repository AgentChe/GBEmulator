//
//  EmulatorViewModel.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 10.06.2024.
//

import RxSwift
import RxCocoa

final class EmulatorViewModel {
    enum Route {
        case dismiss
    }
    
    enum Action {
        case error
        case gameUrl(URL)
    }
    
    private lazy var activity = RxActivityIndicator()
    
    private let source: Driver<Source>
    
    private lazy var gamesManager = GamesManager()
    
    init(cartridge: Cartridge) {
        source = BehaviorRelay(value: .cartridge(cartridge)).asDriver()
    }
    
    init(game: Game) {
        source = BehaviorRelay(value: .game(game)).asDriver()
    }
}

// MARK: Public
extension EmulatorViewModel {
    struct Input {
        let didTapExit: Signal<Void>
    }
    
    struct Output {
        let route: Driver<Route>
        let action: Driver<Action>
        let activity: Driver<Bool>
    }
    
    func configure(input: Input) -> Output {
        Output(
            route: makeRoute(didTapExit: input.didTapExit),
            action: makeAction(),
            activity: activity.asDriver()
        )
    }
}

// MARK: Private
private extension EmulatorViewModel {
    enum Source {
        case cartridge(Cartridge)
        case game(Game)
    }
    
    func makeRoute(didTapExit: Signal<Void>) -> Driver<Route> {
        let dismiss = didTapExit
            .map { Route.dismiss }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver.merge(dismiss)
    }
    
    func makeAction() -> Driver<Action> {
        source
            .flatMapLatest { [weak self] source -> Driver<URL?> in
                guard let self else { return .never() }
                
                switch source {
                case .game(let game):
                    return .just(game.source)
                case .cartridge(let cartridge):
                    return self.gamesManager
                        .uploadGame(fileURL: cartridge.path)
                        .trackActivity(self.activity)
                        .catchAndReturn(nil)
                        .asDriver(onErrorJustReturn: nil)
                }
            }
            .map { game -> Action in
                guard
                    let game,
                    let url = URL(string: GlobalDefinitions.emulatorDomain + "/emulator?game=\(game.absoluteString)")
                else {
                    return .error
                }
                
                return .gameUrl(url)
            }
    }
}
