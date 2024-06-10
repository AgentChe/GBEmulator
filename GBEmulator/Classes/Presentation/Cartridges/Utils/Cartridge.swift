//
//  Cartridge.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import Foundation

final class Cartridge {
    let path: URL
    
    init(path: URL) {
        self.path = path
    }
    
    var name: String {
        (path.lastPathComponent as NSString).deletingPathExtension
    }
}
