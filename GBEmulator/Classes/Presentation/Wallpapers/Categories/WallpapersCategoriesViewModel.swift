//
//  WallpapersCategoriesViewModel.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import RxSwift
import RxCocoa

final class WallpapersCategoriesViewModel {
    enum Route {
        case close
        case selected(WallpaperCategory)
    }
    
    private lazy var activity = RxActivityIndicator()
    
    private lazy var wallpapersManager = WallpapersManager()
}

// MARK: Public
extension WallpapersCategoriesViewModel {
    struct Input {
        let didTapClose: Signal<Void>
        let didSelect: Signal<WallpaperCategory>
    }
    
    struct Output {
        let elements: Driver<[WallpaperCategory]>
        let route: Driver<Route>
        let activity: Driver<Bool>
    }
    
    func configure(input: Input) -> Output {
        Output(
            elements: makeElements(),
            route: makeRoute(
                didTapClose: input.didTapClose,
                didSelect: input.didSelect
            ),
            activity: activity.asDriver()
        )
    }
}

// MARK: Private
private extension WallpapersCategoriesViewModel {
    func makeElements() -> Driver<[WallpaperCategory]> {
        wallpapersManager
            .obtainCategories()
            .trackActivity(activity)
            .asDriver(onErrorJustReturn: [])
    }
    
    func makeRoute(
        didTapClose: Signal<Void>,
        didSelect: Signal<WallpaperCategory>
    ) -> Driver<Route> {
        let close = didTapClose
            .map { Route.close }
            .asDriver(onErrorDriveWith: .never())
        
        let selected = didSelect
            .map { Route.selected($0) }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(close, selected)
    }
}
