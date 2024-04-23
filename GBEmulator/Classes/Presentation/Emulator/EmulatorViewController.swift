//
//  EmulatorViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import UIKit
import SwiftUI

final class EmulatorViewController: UIViewController {
    deinit {
        print("___ deinit")
    }
    
    private let cartridge: Cartridge
    
    private init(cartridge: Cartridge) {
        self.cartridge = cartridge
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mmu = MMU()
        let ppu = PPU(mmu)
        let cpu = CPU(mmu)
        let apu = APU(mmu)
        let timer = Timer(mmu)
        let joypad = Joypad(mmu)
        let clock = Clock(mmu, ppu, cpu, apu, timer)
        let gameLibraryManager = GameLibraryManager(clock)
        
        clock.start()
        
        let ui = UIHostingController(rootView: GameBoyView(lcd: ppu.view).environmentObject(joypad.buttons).environmentObject(gameLibraryManager))
        
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ui.view)
        
        ui.view.translatesAutoresizingMaskIntoConstraints = false
        ui.view.topAnchor.constraint(equalTo: view.topAnchor).isActive =  true
        ui.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive =  true
        ui.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive =  true
        ui.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive =  true
        
        gameLibraryManager.insertCartridge(cartridge)
        
        // TODO
//        cartridge.saveRam()
    }
}

// MARK: Public
extension EmulatorViewController {
    static func make(cartridge: Cartridge) -> EmulatorViewController {
        EmulatorViewController(cartridge: cartridge)
    }
}
