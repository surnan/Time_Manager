//
//  ComponentsList.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class ComponentsListViewController: UITableViewController {
    
    var delegate: TasksListViewController?
    
    var components = ["Alphie", "Animal", "Panda Man", "Kermit"]
    
    //MARK:- UI Functions
    private func setupNavBar(){
        navigationItem.title = "Components List VC"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handlerLeft))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .done, target: self, action: #selector(handlerRight))
    }
    
    @objc private func handlerLeft(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handlerRight(){
        print("Handle Right")
        let newVC = CreateComponentsListViewController()
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = UIColor.lightBlue
        
        tableView.register(ComponentsListTableViewCell.self, forCellReuseIdentifier: componentTableID)
        
    }
}


/*
 //MARK:- UI
 private func setupNavigationBar(){
 navigationItem.title = "Hello World"
 navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cncel", style: .plain, target: self, action: #selector(handleLeftBarButton))
 navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleRightBarButton))
 }
 
 @objc func handleLeftBarButton(){
 print("left button pressed")
 }
 
 @objc private func handleRightBarButton(){
 print("right button pressed")
 let newVC = CreateTaskViewController()
 newVC.delegate = self
 navigationController?.pushViewController(newVC, animated: true)
 }
 */
