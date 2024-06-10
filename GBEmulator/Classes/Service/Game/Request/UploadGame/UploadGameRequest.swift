//
//  UploadGameRequest.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 10.06.2024.
//

import Alamofire

struct UploadGameRequest: APIRequestBody {
    var url: String {
        GlobalDefinitions.emulatorDomain + "/upload"
    }
    
    var method: HTTPMethod {
        .post
    }
}
