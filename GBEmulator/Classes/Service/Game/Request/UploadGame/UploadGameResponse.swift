//
//  .swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 10.06.2024.
//

import Foundation

enum UploadGameResponse {
    static func url(from response: Any) -> URL? {
        guard
            let json = response as? [String: Any],
            let body = json["body"] as? [String],
            let path = body.first,
            let fullPath = (GlobalDefinitions.emulatorDomain + "/" + path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return nil
        }
        
        return URL(string: fullPath)
    }
}
