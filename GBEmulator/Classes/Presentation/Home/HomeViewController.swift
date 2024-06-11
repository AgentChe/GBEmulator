//
//  HomeViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import UIKit
import SwiftUI

final class HomeViewController: UIHostingController<HomeView> {
    init() {
        var homeView = HomeView()
        
        super.init(rootView: homeView)
        
        homeView.didTapMenu = { [weak self] in
            let vc = MenuViewController.make()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        homeView.didTapGameLibrary = { [weak self] in
            let vc = CartridgesViewController.make()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        homeView.didTapWallpapers = { [weak self] in
            let vc = WallpapersCategoriesViewController.make()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        homeView.didTapGameRoms = { [weak self] in
            let vc = GamesViewController.make()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        rootView = homeView
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.main100
    }
}

extension HomeViewController {
    static func make() -> HomeViewController {
        HomeViewController()
    }
}
