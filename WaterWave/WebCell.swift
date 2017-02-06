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
    
    @IBOutlet weak var webview: UIWebView!
    var changeHeight: ((CGFloat?) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        addSubview(webView)
//        view = webView
        webview.scrollView.isScrollEnabled = false
    }
    func fill() {
//        let myURL = URL(string: "http://advisa.work/bank_partner/webview01.html")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
        if webview.delegate == nil {
            if let url = URL(string: "http://advisa.work/bank_partner/webview01.html") {
                let urlRequest = URLRequest(url: url)
                webview.loadRequest(urlRequest)

            }
        } else {
//            stopObservingHeight()
//            startObservingHeight()
        }
        
    }
    
    var observing = false
    func startObservingHeight() {
        let options = NSKeyValueObservingOptions([.old])
        observing = true
        webview.addObserver(self, forKeyPath: "scrollView.contentSize", options: options, context: nil)
    }
    
    func stopObservingHeight() {
        webview.removeObserver(self, forKeyPath: "scrollView.wfcontentSize", context: nil)
        observing = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("asdf", (change as! [NSKeyValueChangeKey: NSValue]), webview.scrollView.contentSize.height)
        
        if let zeChange = change as? [NSKeyValueChangeKey: NSValue] {
            let oldSize = zeChange[NSKeyValueChangeKey.newKey]?.cgSizeValue
            let newSize = zeChange[NSKeyValueChangeKey.newKey]?.cgSizeValue
//            changeHeight?(oldSize?.height)
            changeHeight?(webview.scrollView.contentSize.height)
        }
    }    
}
