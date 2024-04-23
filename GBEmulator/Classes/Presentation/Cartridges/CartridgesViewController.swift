//
//  CartridgesViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 22.04.2024.
//

import UIKit
import SwiftUI

final class CartridgesViewController: UIViewController {
    var onClose: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mmu = MMU()
        let ppu = PPU(mmu)
        let cpu = CPU(mmu)
        let apu = APU(mmu)
        let timer = Timer(mmu)
        let joypad = Joypad(mmu)
        let clock = Clock(mmu, ppu, cpu, apu, timer)
        let glm = GameLibraryManager(clock)
        
        let cartridgesView = CartridgesView(gameLibraryManager: glm, didSelect: { cartridge in
            print("select \(cartridge.title)")
        })
        
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
        
        // TODO
//        clock.start()
//        self.onClose = {
//            glm.inserted.saveRam()
//        }
    }
}

// MARK: Public
extension CartridgesViewController {
    static func make() -> CartridgesViewController {
        let vc = CartridgesViewController()
        vc.navigationItem.title = "Cartridges.Title".localized
        return vc
    }
}
