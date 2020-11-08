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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureTableView()
    {
        //_tableNode.view.tableFooterView = [[UIView alloc] init];
        //_tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

// MARK: - Public
extension HomeDetailViewController {
    
}

// MARK: - Setup
private extension HomeDetailViewController {
    
    func setupUI() {
        
        navigationView.setup(title: "")
        navigationView.showBack()
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
