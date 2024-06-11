//
//  SplashViewController.swift
//  Soccer
//
//  Created by Андрей Чернышев on 05.07.2022.
//

import UIKit
import RxSwift

final class SplashViewController: UIViewController {
    private lazy var mainView = SplashView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var sdkInitialize = SplashReceiptValidationObserver()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sdkInitialize.observe { [weak self] in
            self?.goNext()
        }
    }
}

// MARK: Make
extension SplashViewController {
    static func make() -> SplashViewController {
        SplashViewController()
    }
}

// MARK: Private
private extension SplashViewController {
    func goNext() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            self?.route()
        }
    }
    
    func route() {
        if !OnboardingViewController.wasViewed() {
            UIApplication.shared.keyWindow?.rootViewController = OnboardingViewController.make()
        } else {
            if SessionManager().hasActiveSubscriptions() {
                UIApplication.shared.keyWindow?.rootViewController = NavigationController(rootViewController: HomeViewController.make())
            } else {
                let vc = PaygateViewController.make {
                    UIApplication.shared.keyWindow?.rootViewController = NavigationController(rootViewController: HomeViewController.make())
                }
                present(vc, animated: true)
            }
        }
    }
}
