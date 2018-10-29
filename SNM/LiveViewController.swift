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


class LiveViewController: SNMUIViewController,WKNavigationDelegate,WKUIDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 120, width: self.view.frame.size.width, height: self.view.frame.size.height))
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
        
        //        activityIndicator = UIActivityIndicatorView()
        //        activityIndicator.center = self.view.center
        //        activityIndicator.hidesWhenStopped = true
        //        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        //
        //        view.addSubview(activityIndicator)
        
        let url = URL(string: "http://live.nirankari.org/")
        webView.load(URLRequest(url: url!))
        
        //        if let url = URL(string: "http://live.nirankari.org/") {
        //            if UIApplication.shared.canOpenURL(url) {
        //                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //            }
        // Do any additional setup after loading the view.
        

        // Do any additional setup after loading the view.
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
