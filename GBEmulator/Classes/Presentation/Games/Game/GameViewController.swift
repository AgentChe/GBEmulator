//
//  GameViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import UIKit
import RxSwift

final class GameViewController: UIViewController {
    private lazy var mainView = GameView()
    
    private let viewModel: GameViewModel
    
    private lazy var disposeBag = DisposeBag()
    
    private init(game: Game) {
        viewModel = GameViewModel(game: game)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: GameViewModel.Input(
            didTapClose: mainView.navBar.backButton.rx.tap.asSignal(),
            didTapPlay: mainView.playButton.rx.tap.asSignal()
        ))
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        output.elements
            .drive(Binder(mainView.tableView) { base, elements in
                base.setup(elements: elements)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension GameViewController {
    static func make(game: Game) -> GameViewController {
        GameViewController(game: game)
    }
}

// MARK: Private
private extension GameViewController {
    func route(_ route: GameViewModel.Route) {
        switch route {
        case .dismiss:
            navigationController?.popViewController(animated: true)
        case .play(let game):
            let vc = EmulatorViewController.make(game: game)
            present(vc, animated: true)
        case .paygate:
            let vc = PaygateViewController.make()
            present(vc, animated: true)
        }
    }
}
