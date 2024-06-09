//
//  GamesViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit
import RxSwift

final class GamesViewController: UIViewController {
    private lazy var mainView = GamesView()
    
    private lazy var viewModel = GamesViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: GamesViewModel.Input(
            didTapClose: mainView.navBar.backButton.rx.tap.asSignal(),
            didSearch: mainView.searchField.textField.rx.text.compactMap { $0 }.asSignal(onErrorJustReturn: ""),
            didSelect: mainView.collectionView.didSelect
        ))
        
        output.activity
            .drive(Binder(mainView.preloader) { base, activity in
                activity ? base.startAnimating() : base.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        output.elements
            .drive(Binder(mainView.collectionView) { base, elements in
                base.setup(elements: elements)
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension GamesViewController {
    static func make() -> GamesViewController {
        GamesViewController()
    }
}

// MARK: Private
private extension GamesViewController {
    func route(_ route: GamesViewModel.Route) {
        switch route {
        case .dismiss:
            navigationController?.popViewController(animated: true)
        case .game(let game):
            let vc = GameViewController.make(game: game)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
