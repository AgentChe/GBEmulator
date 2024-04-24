//
//  CartridgesViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 22.04.2024.
//

import UIKit
import SwiftUI

final class CartridgesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cartridgesView = CartridgesView { [weak self] cartridge in
            let vc = EmulatorViewController.make(cartridge: cartridge)
            self?.present(vc, animated: true)
        }
        
        let hostingController = UIHostingController(rootView: cartridgesView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.backgroundColor = Appearance.main100
        hostingController.view.backgroundColor = UIColor.clear
    }
}

// MARK: Public
extension CartridgesViewController {
    static func make() -> CartridgesViewController {
        CartridgesViewController()
    }
}
