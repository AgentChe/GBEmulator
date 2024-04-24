//
//  GameLibraryStorage.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 23.04.2024.
//

import Foundation

class GameLibraryStorage: ObservableObject {
    @Published private(set) var library: [Cartridge]
    
    init() {
        let bundledGames = FileSystem.listAbsoluteURLs(inDirectory: Bundle.main.bundlePath, suffix: ".gb")
        let importedGames = FileSystem.listAbsoluteURLs(inDirectory: FileSystem.documentsDirectory, suffix: ".gb")
        
        let bundledCarts = bundledGames.map { romPath -> Cartridge in
            let ramPath = URL(fileURLWithPath: "\(FileSystem.documentsDirectory)/\(romPath.lastPathComponent).ram")
            return Cartridge(romPath: romPath, ramPath: ramPath)
        }
        let importedCarts = importedGames.map { romPath -> Cartridge in
            return Cartridge(romPath: romPath, ramPath: romPath.appendingPathExtension("ram"))
        }
        let allCarts = bundledCarts + importedCarts
        
        self.library = allCarts
    }
    
    func deleteCartridge(_ discarded: Cartridge) {
        library = library.filter { $0 !== discarded }
        
        try? FileSystem.removeItem(at: discarded.romPath)
        try? FileSystem.removeItem(at: discarded.ramPath)
    }
    
    func importURLs(urls: [URL]) {
        library.append(contentsOf: urls.map { src in
            let romPath = URL(fileURLWithPath: "\(FileSystem.documentsDirectory)/\(src.lastPathComponent)")
            let ramPath = romPath.appendingPathExtension("ram")
            try? FileSystem.moveItem(at: src, to: romPath)
            return Cartridge(romPath: romPath, ramPath: ramPath)
        })
    }
}
