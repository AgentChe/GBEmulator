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
        mmu.reset()
        ppu.reset()
        cpu.reset()
        apu.reset()
        timer.reset()
        clock.stop()
    }
    
    private lazy var mmu = MMU()
    private lazy var ppu = PPU(mmu)
    private lazy var cpu = CPU(mmu)
    private lazy var apu = APU(mmu)
    private lazy var timer = Timer(mmu)
    private lazy var joypad = Joypad(mmu)
    private lazy var clock = Clock(mmu, ppu, cpu, apu, timer)
    private lazy var gameLibraryManager = GameLibraryManager(clock, cartridge: cartridge) 
    
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
        
        let emulatorView = EmulatorView(
            title: cartridge.title,
            lcd: ppu.view
        ) { [weak self] in
            self?.dismiss()
        }
        .environmentObject(joypad.buttons)
        
        let hostingController = UIHostingController(rootView: emulatorView)
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
        
        gameLibraryManager.insertCartridge()
        clock.start()
    }
}

// MARK: Public
extension EmulatorViewController {
    static func make(cartridge: Cartridge) -> EmulatorViewController {
        let vc = EmulatorViewController(cartridge: cartridge)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension EmulatorViewController {
    func dismiss() {
        cartridge.saveRam()
        dismiss(animated: true)
    }
}
