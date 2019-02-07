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
        
        //refresh interval in seconds 43200=12hrs
        Timer.scheduledTimer(timeInterval: 14400, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
  
    @objc func update() {
        webView.reload()
    }
    //MARK:- WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
    
    //WKUIDelegate
    //handles the ok/cancel dialogue box
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
    
    //handles the ok alert dialgoue.
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void)
    {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completionHandler()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
        
   
}


