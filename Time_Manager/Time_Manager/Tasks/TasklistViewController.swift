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
    
    
    
    //MARK:- UI
    private func setupNavigationBar(){
        navigationItem.title = "Hello World"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cncel", style: .plain, target: self, action: #selector(handleLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleLeftBarButton))
    }
    
    @objc func handleLeftBarButton(){
        print("left button pressed")
    }

    @objc private func handleRightBarButton(){
        print("left button pressed")
    }
    
    
    //MARK:- Swift UI functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.tableView.register(TasksListTableViewCell.self, forCellReuseIdentifier: taskTableID)
        view.backgroundColor = UIColor.yellow
    }
}

