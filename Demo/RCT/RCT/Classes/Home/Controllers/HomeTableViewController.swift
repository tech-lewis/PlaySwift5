//
//  HomeTableViewController.swift
//  SwiftMRK
//
//  Created by Mark on 2020/3/23.
//  Copyright © 2020年 markmarklewis. All rights reserved.
//
import UIKit

class HomeTableViewController: UITableViewController {
    // MARK: - 属性
    var listDatas:[String] = [String]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    // MARK: - 设置数据
    func setupData(){
        for i in 1...100 {
            listDatas.append("详情---\(i)")
        }
    }
}


extension HomeTableViewController {
    // 数据源和代理方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listDatas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "homeDetailCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier:  identifier)
        }
        // Configure the cell...
        //setup
        cell?.textLabel?.text = listDatas[indexPath.row]

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
