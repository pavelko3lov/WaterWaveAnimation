//
//  WebCell.swift
//  WaterWave
//
//  Created by Pavel Kozlov on 06/02/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import UIKit
import WebKit


var MyObservationContext = 0

class WebCell: UITableViewCell {
//    var webView : WKWebView!
    
    @IBOutlet weak var heightCoverConstraint: NSLayoutConstraint!
    @IBOutlet weak var webview: UIWebView!
    var changeHeight: ((CGFloat?) -> ())?
    
    var webV : WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        addSubview(webView)
//        view = webView
        webview.scrollView.isScrollEnabled = false
        
        let webConfiguration = WKWebViewConfiguration()
        webV = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), configuration: webConfiguration)
        
        addSubview(webV)
        webV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
    func fill() {
//        let myURL = URL(string: "http://advisa.work/bank_partner/webview01.html")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
        
        if webV.uiDelegate == nil {
            if let url = URL(string: "http://advisa.work/bank_partner/webview01.html") {
                let urlRequest = URLRequest(url: url)
                    
                webV.load(urlRequest)
                
//                webview.loadRequest(urlRequest)
            }
        }
        
    }
    
    var observing = false
    func startObservingHeight() {
        let options = NSKeyValueObservingOptions([.old])
        observing = true
        
        webview.scalesPageToFit = true
        webview.contentMode = .scaleAspectFit

        webV.addObserver(self, forKeyPath: "scrollView.contentSize", options: options, context: nil)
//        webview.addObserver(self, forKeyPath: "scrollView.contentSize", options: options, context: nil)
//        webview.addObserver(self, forKeyPath: "frame", options: options, context: nil)
    
//        webview.addObserver(self, forKeyPath: "scrollView.contentOffset", options: options, context: nil)
//        webview.addObserver(self, forKeyPath: "frame", options: options, context: nil)
    }
    
    func stopObservingHeight() {
//        webview.removeObserver(self, forKeyPath: "scrollView.wfcontentSize", context: nil)
//        webview.removeObserver(self, forKeyPath: "frame", context: nil)
        
        observing = false
    }
    
    var initial: CGFloat = 0.0
    var prev: CGFloat = 0.0
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(">>> ", keyPath!, (change as! [NSKeyValueChangeKey: NSValue]), webV.scrollView.contentSize.height)
        
        if let _ = change as? [NSKeyValueChangeKey: NSValue] {
//            let oldSize = zeChange[NSKeyValueChangeKey.newKey]?.cgSizeValue
//            let newSize = zeChange[NSKeyValueChangeKey.newKey]?.cgSizeValue
//            changeHeight?(oldSize?.height)
            changeHeight?(webV.scrollView.contentSize.height)
//            if prev > 0 && prev < webview.scrollView.contentSize.height {
//                webview.scrollView.contentSize.height = initial
//            }
//            else {
//                prev = max(webview.scrollView.contentSize.height, prev)
//            }
            
//            heightCoverConstraint.constant = webview.scrollView.contentSize.height
            
//            webview.frame.size = webview.sizeThatFits(CGSize.zero)
//            webview.layoutIfNeeded()
//            webview.setNeedsLayout()
//            webview.layoutIfNeeded()
//            webview.layoutMarginsDidChange()
        }
    }    
}
