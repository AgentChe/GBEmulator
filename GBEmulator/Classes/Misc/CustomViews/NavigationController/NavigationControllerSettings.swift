//
//  NursingNavigationControllerSettings.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit

struct NavigationControllerSettings {
    let backgroundImage: UIImage
    let shadowImage: UIImage
    let isTranslucent: Bool
    let tintColor: UIColor
    let titleTextAttrributes: [NSAttributedString.Key: Any]
    let navBarHidden: Bool
}

// MARK: Make
extension NavigationControllerSettings {
    static func `default`() -> NavigationControllerSettings {
        NavigationControllerSettings(backgroundImage: UIImage(),
                                     shadowImage: UIImage(),
                                     isTranslucent: true,
                                     tintColor: UIColor.black,
                                     titleTextAttrributes: TextAttributes()
                                        .textColor(UIColor.black)
                                        .font(Fonts.Joystix.monospace(size: 18.scale))
                                        .textAlignment(.center)
                                        .dictionary,
                                     navBarHidden: true)
    }
}
