//
//  EmulatorWebView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 07.06.2024.
//

import UIKit
import WebKit

final class EmulatorWebView: UIView {
    enum Command: String {
        case play = "sendGameAction('play')"
        case pause = "sendGameAction('pause')"
        case restart = "sendGameAction('restart')"
        case select = "sendGameAction('select')"
        case start = "sendGameAction('start')"
        
        case leftDown = "sendControllDownAction('left')"
        case rightDown = "sendControllDownAction('right')"
        case upDown = "sendControllDownAction('up')"
        case downDown = "sendControllDownAction('down')"
        
        case aDown = "sendControllDownAction('A')"
        case bDown = "sendControllDownAction('B')"
        case lDown = "sendControllDownAction('L')"
        case rDown = "sendControllDownAction('R')"
        
        case leftUp = "sendControllUpAction('left')"
        case rightUp = "sendControllUpAction('right')"
        case upUp = "sendControllUpAction('up')"
        case downUp = "sendControllUpAction('down')"
        
        case aUp = "sendControllUpAction('A')"
        case bUp = "sendControllUpAction('B')"
        case lUp = "sendControllUpAction('L')"
        case rUp = "sendControllUpAction('R')"
    }
    
    lazy var webView = makeWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension EmulatorWebView {
    func request(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func send(command: Command) {
        webView.evaluateJavaScript(command.rawValue)
    }
}

// MARK: WKNavigationDelegate
extension EmulatorWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
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
        
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.preferences = preferences
        
        let view = WKWebView(frame: .zero, configuration: webViewConfig)
        view.navigationDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
