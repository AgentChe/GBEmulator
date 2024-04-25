//
//  MenuViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import UIKit
import SwiftUI

final class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuView = MenuView(didTapClose: { [weak self] in
            self?.dismiss(animated: true)
        }, didTapTermsOfUse: {
            UIApplication.shared.open(GlobalDefinitions.termsOfUseUrl)
        }, didTapPrivacyPolicy: {
            UIApplication.shared.open(GlobalDefinitions.privacyPolicyUrl)
        }, didTapContactUs: {
            UIApplication.shared.open(GlobalDefinitions.contactUsUrl)
        })
        
        let hostingController = UIHostingController(rootView: menuView)
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
extension MenuViewController {
    static func make() -> MenuViewController {
        let vc = MenuViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
