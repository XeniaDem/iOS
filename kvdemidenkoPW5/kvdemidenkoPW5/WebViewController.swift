//
//  WebViewController.swift
//  kvdemidenkoPW5
//
//  Created by Ксения Демиденко on 20.11.2021.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    var url: URL?
    var webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinRight(to: view)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        webView.pinLeft(to: view)
        webView.load(URLRequest(url: (url ?? URL(string: ""))!))
        view.backgroundColor = .white
    }
}

