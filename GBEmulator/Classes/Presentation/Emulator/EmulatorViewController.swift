//
//  EmulatorViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit

final class EmulatorViewController: UIViewController {
    private lazy var mainView = EmulatorView()
    
    override func loadView() {
        view = mainView
    }
    
    override var shouldAutorotate: Bool {
        true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .landscapeRight
    }
}

// MARK: Public
extension EmulatorViewController {
    static func make(cartridge: Cartridge) -> EmulatorViewController {
        let vc = EmulatorViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
