//
//  WebCollectionCell.swift
//  WaterWave
//
//  Created by pasha on 06/02/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import UIKit

class WebCollectionCell: UICollectionViewCell {

    @IBOutlet weak var webCollectionView: UIWebView!
    
    var changeHeight: ((CGFloat?) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webCollectionView.scrollView.isScrollEnabled = false
    }
    func fill() {
        if webCollectionView.delegate == nil {
            if let url = URL(string: "http://advisa.work/bank_partner/webview01.html") {
                let urlRequest = URLRequest(url: url)
                webCollectionView.loadRequest(urlRequest)
                
            }
        }
        
    }
    
    var observing = false
    func startObservingHeight() {
        let options = NSKeyValueObservingOptions([.old])
        observing = true
        
        webCollectionView.addObserver(self, forKeyPath: "scrollView.contentSize", options: options, context: nil)
//        webCollectionView.addObserver(self, forKeyPath: "frame", options: options, context: nil)
    }
    
    func stopObservingHeight() {
        webCollectionView.removeObserver(self, forKeyPath: "scrollView.wfcontentSize", context: nil)
//        webCollectionView.removeObserver(self, forKeyPath: "frame", context: nil)
        
        observing = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(">>> ", keyPath!, (change as! [NSKeyValueChangeKey: NSValue]), webCollectionView.scrollView.contentSize.height)
        
        if let zeChange = change as? [NSKeyValueChangeKey: NSValue] {
            let oldSize = zeChange[NSKeyValueChangeKey.newKey]?.cgSizeValue
            let newSize = zeChange[NSKeyValueChangeKey.newKey]?.cgSizeValue
            //            changeHeight?(oldSize?.height)
            changeHeight?(webCollectionView.scrollView.contentSize.height)
        }
    }

}
