//
//  EmulatorViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit
import RxSwift

final class EmulatorViewController: UIViewController {
    private lazy var mainView = EmulatorView()
    
    private let viewModel: EmulatorViewModel
    
    private lazy var disposeBag = DisposeBag()
    
    private init(cartridge: Cartridge) {
        viewModel = EmulatorViewModel(cartridge: cartridge)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    private init(game: Game) {
        viewModel = EmulatorViewModel(game: game)
        
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
        
        Observable<EmulatorWebView.Command>
            .merge(
                mainView.selectButton.rx.tap.map { .select },
                mainView.startButton.rx.tap.map { .start },
                mainView.dPadView.leftButton.rx.controlEvent(.touchDown).map { .leftDown },
                mainView.dPadView.leftButton.rx.controlEvent(.touchUpInside).map { .leftUp },
                mainView.dPadView.rightButton.rx.controlEvent(.touchDown).map { .rightDown },
                mainView.dPadView.rightButton.rx.controlEvent(.touchUpInside).map { .rightUp },
                mainView.dPadView.upButton.rx.controlEvent(.touchDown).map { .upDown },
                mainView.dPadView.upButton.rx.controlEvent(.touchUpInside).map { .upUp },
                mainView.dPadView.downButton.rx.controlEvent(.touchDown).map { .downDown },
                mainView.dPadView.downButton.rx.controlEvent(.touchUpInside).map { .downUp },
                mainView.aButton.rx.controlEvent(.touchDown).map { .aDown },
                mainView.aButton.rx.controlEvent(.touchUpInside).map { .aUp },
                mainView.bButton.rx.controlEvent(.touchDown).map { .bDown },
                mainView.bButton.rx.controlEvent(.touchUpInside).map { .bUp },
                mainView.lButton.rx.controlEvent(.touchDown).map { .lDown },
                mainView.lButton.rx.controlEvent(.touchUpInside).map { .lUp },
                mainView.rButton.rx.controlEvent(.touchDown).map { .rDown },
                mainView.rButton.rx.controlEvent(.touchUpInside).map { .rUp }
            )
            .bind(to: Binder(mainView.webView) { base, command in
                base.send(command: command)
            })
            .disposed(by: disposeBag)
        
        let output = viewModel.configure(input: EmulatorViewModel.Input(
            didTapExit: mainView.exitButton.rx.tap.asSignal()
        ))
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        output.action
            .drive(Binder(self) { base, action in
                base.action(action)
            })
            .disposed(by: disposeBag)
        
        output.activity
            .drive(Binder(self) { base, activity in
                base.activity(activity)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (UIApplication.shared.delegate as? AppDelegate)?.restrictRotation = .landscape
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        (UIApplication.shared.delegate as? AppDelegate)?.restrictRotation = .portrait
    }
}

// MARK: Public
extension EmulatorViewController {
    static func make(cartridge: Cartridge) -> EmulatorViewController {
        let vc = EmulatorViewController(cartridge: cartridge)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    static func make(game: Game) -> EmulatorViewController {
        let vc = EmulatorViewController(game: game)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension EmulatorViewController {
    func route(_ route: EmulatorViewModel.Route) {
        switch route {
        case .dismiss:
            dismiss(animated: true)
        }
    }
    
    func action(_ action: EmulatorViewModel.Action) {
        switch action {
        case .error:
            let alert = UIAlertController(
                title: "Games.Error.Title".localized, 
                message: "Games.Error.Text".localized,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Games.Error.Button".localized, style: .cancel)
            alert.addAction(okAction)
            
            present(alert, animated: true)
        case .gameUrl(let url):
            mainView.webView.request(url: url)
        }
    }
    
    func activity(_ activity: Bool) {
        [
            mainView.lButton,
            mainView.dPadView,
            mainView.startButton,
            mainView.selectButton,
            mainView.webView,
            mainView.rButton,
            mainView.aButton,
            mainView.bButton,
            mainView.exitButton
        ].forEach { $0.isHidden = activity }
        
        activity ? mainView.preloader.startAnimating() : mainView.preloader.stopAnimating()
    }
}
