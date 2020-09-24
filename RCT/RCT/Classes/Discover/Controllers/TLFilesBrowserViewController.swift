//
//  TLFilesBrowserViewController.swift
//  SwiftMRK
//
//  Created by Mark on 2020/3/23.
//  Copyright © 2020年 markmarklewis. All rights reserved.
//  com.marklewis

import UIKit
import MediaPlayer
class TLFilesBrowserViewController: UITableViewController {

    var filesData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        //setup
        cell?.textLabel?.text = "\(self.filesData[indexPath.row])😄"
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //click action
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentPaths: NSString
        documentPaths = docPath as NSString

        let mediaURL =
        URL(fileURLWithPath: documentPaths.appendingPathComponent(self.filesData[indexPath.row]) as String)
        let playerVC = MPMoviePlayerViewController(contentURL: mediaURL)
            
        
        self.present(playerVC!, animated: true) {
            //
        }
    }
}
