//
//  UIEdgeInsets+Extension.swift
//  RingSizer
//
//  Created by Андрей Чернышев on 25.03.2024.
//

import UIKit
import SwiftUI

extension UIEdgeInsets {
    init(value: CGFloat) {
        self = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    init(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
        self = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    init(t: CGFloat = 0, l: CGFloat = 0, b: CGFloat = 0, r: CGFloat = 0) {
        self = UIEdgeInsets(top: t, left: l, bottom: b, right: r)
    }
}

extension EdgeInsets {
    init(value: CGFloat) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }
    
    init(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    init(t: CGFloat = 0, l: CGFloat = 0, b: CGFloat = 0, r: CGFloat = 0) {
        self.init(top: t, leading: l, bottom: b, trailing: r)
    }
}
