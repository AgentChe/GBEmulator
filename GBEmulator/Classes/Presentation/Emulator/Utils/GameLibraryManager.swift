import Foundation

class GameLibraryManager {
    let clock: Clock
    let cartridge: Cartridge
    
    init(_ clock: Clock, cartridge: Cartridge) {
        self.clock = clock
        self.cartridge = cartridge
    }
    
    func insertCartridge() {
        clock.sync { [weak self] mmu, cpu, ppu, apu, timer in
            guard let self else {
                return
            }
            
            mmu.insertCartridge(self.cartridge)
            mmu.reset()
            cpu.reset()
            ppu.reset()
            apu.reset()
            timer.reset()
        }
    }
}
