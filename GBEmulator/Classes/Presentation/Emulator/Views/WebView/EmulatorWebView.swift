//
//  EmulatorWebView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit
import WebKit

final class EmulatorWebView: UIView {
    enum Commands: String {
        case play = "play"
        case pause = "pause"
        case restart = "restart"
        case select = "select"
        case start = "start"
    }
    
    lazy var webView = makeWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: WKNavigationDelegate
extension EmulatorWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}

// MARK: WKScriptMessageHandler
extension EmulatorWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print()
    }
}

// MARK: Private
private extension EmulatorWebView {
    func initialize() {
        let url = URL(string: "https://games.sergei-mobile.com/emulator?game=assets/games/users/1421 - Max Payne Advance (E)(Rising Sun).gba")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: Make constraints
private extension EmulatorWebView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension EmulatorWebView {
    func makeWebView() -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let config = WKWebViewConfiguration()
        let handler = JSMessageHandler(delegate: self)
        config.userContentController.add(handler, name: "callback_name")
        config.preferences = preferences
        
        let view = WKWebView(frame: .zero, configuration: config)
        view.navigationDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
