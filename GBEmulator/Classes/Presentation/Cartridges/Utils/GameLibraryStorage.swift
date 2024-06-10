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
        let bundledGames = FileSystem.listAbsoluteURLs(inDirectory: Bundle.main.bundlePath, suffix: ".gba")
        let importedGames = FileSystem.listAbsoluteURLs(inDirectory: FileSystem.documentsDirectory, suffix: ".gba")
        
        let bundledCarts = bundledGames.map { romPath -> Cartridge in
            Cartridge(path: romPath)
        }
        let importedCarts = importedGames.map { romPath -> Cartridge in
            Cartridge(path: romPath)
        }
        let allCarts = bundledCarts + importedCarts
        
        self.library = allCarts
    }
    
    func deleteCartridge(_ discarded: Cartridge) {
        library = library.filter { $0 !== discarded }
        
        try? FileSystem.removeItem(at: discarded.path)
    }
    
    func importURLs(urls: [URL]) {
        library.append(contentsOf: urls.map { src in
            let romPath = URL(fileURLWithPath: "\(FileSystem.documentsDirectory)/\(src.lastPathComponent)")
            try? FileSystem.moveItem(at: src, to: romPath)
            return Cartridge(path: romPath)
        })
    }
}
