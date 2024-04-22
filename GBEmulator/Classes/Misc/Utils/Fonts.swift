//
//  Fonts.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit

struct Fonts {
    // MARK: RobotoMono
    struct RobotoMono {
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "RobotoMono-Bold", size: size)!
        }
        
        static func medium(size: CGFloat) -> UIFont {
            UIFont(name: "RobotoMono-Medium", size: size)!
        }
        
        static func semiBold(size: CGFloat) -> UIFont {
            UIFont(name: "RobotoMono-SemiBold", size: size)!
        }
        
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "RobotoMono-Regular", size: size)!
        }
    }
    
    // MARK: Joystix
    struct Joystix {
        static func monospace(size: CGFloat) -> UIFont {
            UIFont(name: "JoystixMonospace-Regular", size: size)!
        }
    }
}
