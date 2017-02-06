//
//  WebTableViewController.swift
//  WaterWave
//
//  Created by Pavel Kozlov on 06/02/2017.
//  Copyright © 2017 DeveloperLx. All rights reserved.
//

import UIKit
import WebKit

class WebTableViewController: UITableViewController, UIWebViewDelegate {//WKUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.register(UINib(nibName: "WebCell", bundle: nil), forCellReuseIdentifier: "WebCell")
//        tableView.estimatedRowHeight = 
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return webViewHeight
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebCell", for: indexPath) as! WebCell
        // Configure the cell...
        cell.fill()
        cell.webview.delegate = self
        cell.changeHeight = { [weak self] height in
            if let height = height {
                self?.webViewHeight = height
//                print("webViewHeight", self!.webViewHeight)
                self?.tableView.reloadData()
//                self?.resizeCollectionView()
            }
        }
        return cell
    }
    var webViewHeight : CGFloat = 0
    
    
    public func webViewDidStartLoad(_ webView: UIWebView) {}
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        if let str = webView.stringByEvaluatingJavaScript(from: "(document.height !== undefined) ? document.height : document.body.offsetHeight;") {
            webViewHeight = CGFloat((str as NSString).floatValue)
//            tableView.reloadRows(at: [IndexPath(row: 0, section: Sections.webView.rawValue)], with: .automatic)
            tableView.reloadData()
            
            (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? WebCell)?.startObservingHeight()
            
        }
    }
    
    
    func resizeCollectionView() {//_ layout: UICollectionViewLayout) {
//        collectionView?.performBatchUpdates({
//            layout.prepare()
//            self.collectionView?.setCollectionViewLayout(layout, animated: true)
//        }, completion: nil )
//        
//        if let rect = collectionView?.contentOffset {
//            collectionView?.setContentOffset(rect, animated: true)
//        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {}
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
