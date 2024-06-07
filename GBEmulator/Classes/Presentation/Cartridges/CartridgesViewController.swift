//
//  CartridgesViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 22.04.2024.
//

import UIKit
import SwiftUI

final class CartridgesViewController: UIHostingController<CartridgesView> {
    private init() {
        var cartridgesView = CartridgesView()
        
        super.init(rootView: cartridgesView)
        
        cartridgesView.didTapBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        cartridgesView.didSelect = { [weak self] cartridge in
            let hasActiveSubscriptions = SessionManager().hasActiveSubscriptions()
            let vc = hasActiveSubscriptions ? EmulatorViewController.make(cartridge: cartridge) : PaygateViewController.make()
            self?.present(vc, animated: true)
        }
        
        rootView = cartridgesView
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.main100
    }
}

// MARK: Public
extension CartridgesViewController {
    static func make() -> CartridgesViewController {
        CartridgesViewController()
    }
}
