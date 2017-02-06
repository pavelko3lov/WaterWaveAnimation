//
//  WebCollectionViewController.swift
//  WaterWave
//
//  Created by pasha on 06/02/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import UIKit

class WebCollectionViewController: UICollectionViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.lightGray
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView!.register(UINib(nibName: "WebCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WebCollectionCell")
//        self.collectionView!.register(WebCollectionCell.self, forCellWithReuseIdentifier: "WebCollectionCell")
        
//        collectionView?.reloadData()
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    var webViewHeight: CGFloat = 10
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WebCollectionCell", for: indexPath) as! WebCollectionCell
    
        cell.changeHeight = { [weak self] height in
            if let height = height {
                self?.webViewHeight = height
//                print("webViewHeight", self!.webViewHeight)
                collectionView.reloadData()
            }
        }
        cell.fill()
        cell.webCollectionView.delegate = self
        
        return cell
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView) {}
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        if let str = webView.stringByEvaluatingJavaScript(from: "(document.height !== undefined) ? document.height : document.body.offsetHeight;") {
            webViewHeight = CGFloat((str as NSString).floatValue)
//            tableView.reloadRows(at: [IndexPath(row: 0, section: Sections.webView.rawValue)], with: .automatic)
            
            (collectionView?.cellForItem(at: IndexPath(row: 0, section: 0)) as? WebCollectionCell)?.startObservingHeight()
            
                        collectionView?.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: webViewHeight)
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {}

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
