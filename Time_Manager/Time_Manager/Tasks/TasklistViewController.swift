//
//  ViewController.swift
//  Time_Manager
//
//  Created by admin on 5/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class TasksListViewController: UITableViewController {

    var tasks = ["Apple", "Banana", "Peach", "Strawberry", "Pineapple"]
    
    //MARK:- Swift UI functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(TasksListTableViewCell.self, forCellReuseIdentifier: taskTableID)
        view.backgroundColor = UIColor.yellow
    }
}

