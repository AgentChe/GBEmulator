//
//  MenuViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import UIKit
import SwiftUI

final class MenuViewController: UIHostingController<MenuView> {
    init() {
        var menuView = MenuView()
        
        super.init(rootView: menuView)
        
        menuView.didTapClose = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        menuView.didTapTermsOfUse = {
            UIApplication.shared.open(GlobalDefinitions.termsOfUseUrl)
        }
        
        menuView.didTapPrivacyPolicy = {
            UIApplication.shared.open(GlobalDefinitions.privacyPolicyUrl)
        }
        
        menuView.didTapContactUs = {
            UIApplication.shared.open(GlobalDefinitions.contactUsUrl)
        }
        
        rootView = menuView
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.main100
    }
    
    override var shouldAutorotate: Bool {
        true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }
}

// MARK: Public
extension MenuViewController {
    static func make() -> MenuViewController {
        MenuViewController()
    }
}
