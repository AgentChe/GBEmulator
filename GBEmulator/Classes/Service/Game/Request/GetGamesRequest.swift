//
//  GetGamesRequest.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import Alamofire

struct GetGamesRequest: APIRequestBody {
    var url: String {
        GlobalDefinitions.emulatorDomain + "/games"
    }
    
    var method: HTTPMethod {
        .get
    }
}
