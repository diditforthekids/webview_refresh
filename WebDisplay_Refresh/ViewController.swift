//
//  ViewController.swift
//  WebDisplay_Refresh
//
//  Created by Jeff Makoroff on 11/28/18.
//  Copyright © 2018 Jeff Makoroff. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    var websites = "app.meetingroom365.com"
    
    
    
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        webView.uiDelegate = self
        let url = URL(string: "https://" + websites)!
        webView.load(URLRequest(url: url) as URLRequest)
        //Comment out below to disable back/forward
        webView.allowsBackForwardNavigationGestures = true
        
        //refresh
        Timer.scheduledTimer(timeInterval: 43200, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
  
    @objc func update() {
        webView.reload()
    }
    //MARK:- WKNavigationDelegate
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("finish to load")
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
        
   
}


