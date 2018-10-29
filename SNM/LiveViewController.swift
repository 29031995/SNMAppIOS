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


class LiveViewController: SNMUIViewController,WKNavigationDelegate, WKUIDelegate {
    
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.startAnimating()
        
        let url = URL(string: "http://live.nirankari.org/")
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url!))
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        showActivityIndicator(show: true)
//    }
    
    
//    func showActivityIndicator(show: Bool) {
//        if show {
//            activityIndicator.isHidden = false
//            activityIndicator.startAnimating()
//        } else {
//            activityIndicator.stopAnimating()
//        }
//    }
//    
//    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
//        showActivityIndicator(show: false)
//    }
    
}
