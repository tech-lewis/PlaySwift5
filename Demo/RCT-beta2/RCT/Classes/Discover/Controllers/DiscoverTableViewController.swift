//
//  DiscoverTableViewController.swift
//  SwiftMRK
//
//  Created by Mark on 2020/3/23.
//  Copyright © 2020年 markmarklewis. All rights reserved.
//

import UIKit
import Foundation
class DiscoverTableViewController: UITableViewController {

    var listDatas:[String] = [String]()
    
    override func viewDidLoad() {
        //setup
//        listDatas.append("m4v")
//        listDatas.append("mp4")
//        listDatas.append("mp3")
//        listDatas.append("mov")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDatas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "SettingCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)
        }
        
        //setup
        cell?.textLabel?.text = "\(self.listDatas[indexPath.row])  media files"
        cell?.detailTextLabel?.text = "Support iTunes copy files to this app"
        
        return cell!
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //click action
        let fileBrowserVC = TLFilesBrowserViewController()
        fileBrowserVC.filesData = getFileListWithFileExtensionType(type: "mov")
        //let nav = UINavigationController(rootViewController:fileBrowserVC)
        self.navigationController?.pushViewController(fileBrowserVC, animated: true)
    }
    
    
    func getFileListWithFileExtensionType(type: String?) -> [String]
    {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

        

        let fileMgr = FileManager.default
        //var fileList = [String]()
        do{
            let arr = try fileMgr.contentsOfDirectory(atPath: documentPaths)
            
            if let fileExt = type{
                let array = arr as NSArray
                 return (array.pathsMatchingExtensions([fileExt]))
            }
            
            
        }
        catch{
            return [String]()
        }
        
        return [String]()
    }
//
//    if(type.length)
//    {
//    array = @[type];
//    
//    NSArray *fileList = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:string error:nil] pathsMatchingExtensions:array];
//    NSMutableArray *docPaths = [NSMutableArray arrayWithCapacity:fileList.count];
//    for (NSString *name in fileList)
//    {
//    [docPaths addObject:[string stringByAppendingPathComponent:name]];
//    }
//    
//    return docPaths;
//    }
//    
//    return nil;
//    }

}
