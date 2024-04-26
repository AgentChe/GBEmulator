//
//  HomeViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import UIKit
import SwiftUI

final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeView = HomeView(didTapMenu: { [weak self] in
            let vc = MenuViewController.make()
            self?.present(vc, animated: true)
        }, didTapGameLibrary: { [weak self] in
            let vc = CartridgesViewController.make()
            self?.present(vc, animated: true)
        }, didTapWallpapers: { [weak self] in
            let vc = WallpapersCategoriesViewController.make()
            self?.present(vc, animated: true)
        })
        
        let hostingController = UIHostingController(rootView: homeView)
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
extension HomeViewController {
    static func make() -> HomeViewController {
        HomeViewController()
    }
}
