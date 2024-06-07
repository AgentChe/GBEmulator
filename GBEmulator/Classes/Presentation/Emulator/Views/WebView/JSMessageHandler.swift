//
//  JSMessageHandler.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import WebKit

final class JSMessageHandler: NSObject, WKScriptMessageHandler {
    weak var delegate : WKScriptMessageHandler?
    
    init(delegate: WKScriptMessageHandler) {
        self.delegate = delegate
        
        super.init()
    }
    
    func userContentController(_ ucc: WKUserContentController, didReceive message: WKScriptMessage) {
        delegate?.userContentController(ucc, didReceive: message)
    }
}
