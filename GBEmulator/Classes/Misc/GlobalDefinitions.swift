//
//  GlobalDefinitions.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import Foundation

final class GlobalDefinitions {
    static let domain = "https://sergei-mobile.com"
    static let apiKey = "Op4H33209xaUkvQqb"
    
    static let emulatorDomain = "https://games.sergei-mobile.com"
    
    static let otterScaleHost = "https://api.korrekted.com"
    static let otterScaleApiKey = "D29HF7nmzvBpChSB"
    
    static let applicationTag = "EMULATOR"
    static let amplitudeApiKey = "d4ad5c33d23d7a891e9c68de9471f36b"
    
    static let termsOfUseUrl = URL(string: "https://sergei-mobile.com/eula.html")!
    static let privacyPolicyUrl = URL(string: "https://sergei-mobile.com/policy.html")!
    static let contactUsUrl = URL(string: "https://sergei-mobile.com/contact.html")!
    
    enum Paygate {
        static let yearly = "com.gbemulator.yearly"
        static let weekly = "com.gbemulator.weekly"
    }
    
    enum ImportedTypesIds {
        static let gb = "com.gbemulator.file"
    }
}

