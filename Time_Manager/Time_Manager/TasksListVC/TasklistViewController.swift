//
//  ViewController.swift
//  Time_Manager
//
//  Created by admin on 5/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

class TasksListViewController: UITableViewController, manipulatingTaskListViewController {
    
    func addNewTaskToTableView(myTaskItem: TaskItem) {
        tasks.append(myTaskItem)
        let myIndexPath = IndexPath(row: tasks.count - 1, section: 0)
        tableView.insertRows(at: [myIndexPath], with: .left)
    }
    
    func editExistingTaskOnTableView(myTaskItem: TaskItem) {
        let currentRow = tasks.index(of: myTaskItem)
        let myIndexPath = IndexPath(row: currentRow!, section: 0)
        tableView.reloadRows(at: [myIndexPath], with: .middle)
    }
    
    var tasks = [TaskItem]()
    
    //MARK:- UI
    private func setupNavigationBar(){
        navigationItem.title = "Hello World"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cncel", style: .plain, target: self, action: #selector(handleLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleRightBarButton))
    }
    
    @objc func handleLeftBarButton(){
        print("left button pressed")
        tableView.reloadData()
    }
    
    @objc private func handleRightBarButton(){
        //Add/Save
        print("right button pressed")
        let newVC = CreateTaskViewController()
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    
    //MARK:- Swift UI functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
     
        //var tasks = [TaskItem]()
        let myViewContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskItem>(entityName: "TaskItem")
        do {
            tasks = try myViewContext.fetch(fetchRequest)
        } catch let fetchErr {
            fatalError("Unable to load task data from ViewDidLoad.fetchRequest  \(fetchErr)")
        }
        self.tableView.register(TasksListTableViewCell.self, forCellReuseIdentifier: taskTableID)
        view.backgroundColor = UIColor.yellow
    }
}

