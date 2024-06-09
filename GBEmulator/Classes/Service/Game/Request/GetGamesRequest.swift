//
//  GetGamesRequest.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import Alamofire

struct GetGamesRequest: APIRequestBody {
    // TODO: заменить после сборки gba
    var url: String {
        "https://dolphin-app-s5het.ondigitalocean.app/games.json"
    }
    
    var method: HTTPMethod {
        .get
    }
}
