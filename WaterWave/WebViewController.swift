//
//  WebViewController.swift
//  WaterWave
//
//  Created by Pavel Kozlov on 06/02/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UITableViewController, WKUIDelegate {
//    @IBOutlet weak var webView: UIWebView!
    var webView : WKWebView!
    
//    override func loadView() {
//        
//    let webConfiguration = WKWebViewConfiguration()
//    webView = WKWebView(frame: .zero, configuration: webConfiguration)
//    webView.uiDelegate = self
//    view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let myURL = URL(string: "http://advisa.work/bank_partner/webview01.html")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
//        if let url = URL(string: "http://advisa.work/bank_partner/webview01.html") {
//            let urlRequest = URLRequest(url: url)
//            webView.loadRequest(urlRequest)
//        }
        
        
        let javascriptString = "" +
            "var body = document.body;" +
            "var html = document.documentElement;" +
            "Math.max(" +
            "   body.scrollHeight," +
            "   body.offsetHeight," +
            "   html.clientHeight," +
            "   html.offsetHeight" +
        ");"
        
        webView.evaluateJavaScript(javascriptString) { (result, error) in
            if error == nil {
                if let result = result {
                    print("result", result)
//                    self.htmlContentHeight = CGFloat(height)
//                    self.resetContentCell()
                }
            }
        }
        
    }
}
