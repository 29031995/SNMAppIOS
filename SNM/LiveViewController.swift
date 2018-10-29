//
//  LiveViewController.swift
//  SNM
//
//  Created by Nitin Chauhan on 10/29/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import WebKit
import SafariServices


class LiveViewController: SNMUIViewController,WKNavigationDelegate, WKUIDelegate , UIWebViewDelegate{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://live.nirankari.org/")
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url!))
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    
}
