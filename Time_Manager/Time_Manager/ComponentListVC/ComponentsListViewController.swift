//
//  ComponentsList.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData


class ComponentsListViewController: UITableViewController, manipulatingComponentsListViewController {
    
    func addNewComponentToTableView(myComponentItem: ComponentItem) {
        components.append(myComponentItem)
        let myIndexPath = IndexPath(row: components.count - 1, section: 0)
        tableView.insertRows(at: [myIndexPath], with: .left)
    }
    
    func editExistingComponentOnTableView(myComponentItem: ComponentItem) {
        guard let currentRow = components.index(of: myComponentItem) else {return}
        let myIndexPath = IndexPath(row: currentRow, section: 0)
        tableView.reloadRows(at: [myIndexPath], with: .middle)
    }
    
    
    var components = [ComponentItem]()
    var currentTask: TaskItem?
    var delegate: TasksListViewController?
    
    
    //MARK:- UI Functions
    private func setupNavBar(){
        if currentTask != nil {
            navigationItem.title = currentTask?.name
        } else {
            navigationItem.title = "OOoopppss...."
        }
        navigationItem.leftBarButtonItems = [UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(handleLeftBarButton)), UIBarButtonItem(title: "ALL", style: .plain, target: self, action: #selector(handleLeftBarButton2))]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .done, target: self, action: #selector(handleRightBarButton))
    }
    
    @objc private func handleLeftBarButton(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func handleLeftBarButton2(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleRightBarButton(){
        let newVC = CreateComponentsListViewController()
        newVC.parentTask = currentTask
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        currentTask?.linkComponent?.forEach({ (temp) in
            let newTemp = temp as! ComponentItem
            print(newTemp.cName ?? "")
            components.append(newTemp)
        })
        tableView.register(ComponentsListTableViewCell.self, forCellReuseIdentifier: componentTableID)
        view.backgroundColor = UIColor.lightBlue
    }
}

