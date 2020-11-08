//
//  HomeDetailViewController.swift
//  RCT
//
//  Created by mac on 1.11.20.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit
import ApplicationKit

class HomeDetailViewController: UIViewController {
    
    let tableView = ASTableView()
    
    deinit {
        tableView.asyncDelegate = nil // 记得在这里将 delegate 设为 nil，否则有可能崩溃
        tableView.asyncDataSource = nil // dataSource 也是一样
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

    
    func configureTableView()
    {
        //_tableNode.view.tableFooterView = [[UIView alloc] init];
        //_tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

// MARK: - Public
extension HomeDetailViewController: ASTableViewDelegate, ASTableViewDataSource {
    func tableView(_ tableView: ASTableView!, nodeForRowAt indexPath: IndexPath!) -> ASCellNode! {
        let cell = ASTextCellNode()
        cell?.text = "hello world"
        return cell
    }
    
    // MARK: - ASTableView Delegate
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }

//    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {}

}

// MARK: - Setup
private extension HomeDetailViewController {
    
    func setupUI() {
        
        //navigationView.setup(title: "")
        //navigationView.showBack()
    }
    
    func updateUI() {
        
    }
    
}

// MARK: - Action
private extension HomeDetailViewController {
    
}

// MARK: - Utiltiy
private extension HomeDetailViewController {
    
}
