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
    
    var tasks = [TaskItem]()
    

    func addNewTaskToTableView(myTaskItem: TaskItem) {
        tasks.append(myTaskItem)
        tasks.sort() //???
        
        let temp = getIndexofIncomingTask(newTask: myTaskItem)
        let myIndexPath = IndexPath(row: temp, section: 0)
        tableView.insertRows(at: [myIndexPath], with: .left)
    }
    
    func editExistingTaskOnTableView(myTaskItem: TaskItem) {
        guard let currentRow = tasks.index(of: myTaskItem) else {return}
        let myIndexPath = IndexPath(row: currentRow, section: 0)
        tasks.remove(at: currentRow)
        tableView.deleteRows(at: [myIndexPath], with: .left)
        tasks.append(myTaskItem)
        tasks.sort()
        let temp = getIndexofIncomingTask(newTask: myTaskItem)
        let myIndexPath2 = IndexPath(row: temp, section: 0)
        tableView.insertRows(at: [myIndexPath2], with: .right)
    }
    

    //MARK:- UI
    private func setupNavigationBar(){
        navigationItem.title = "Hello World"
        
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(title: "Delete ALL", style: .plain, target: self, action: #selector(handleLeftBarButton)), UIBarButtonItem(title: "sort", style: .plain, target: self, action: #selector(handleLeftBarButton2)), UIBarButtonItem(title: "reload", style: .plain, target: self, action: #selector(handleLeftBarButton3))]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleRightBarButton))
    }
    
    @objc func handleLeftBarButton(){
        print("left button pressed")
        let myViewContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskItem>(entityName: "TaskItem")
        
        do {
            let tempTaskArray = try myViewContext.fetch(fetchRequest)
            tempTaskArray.forEach { (temp) in
                guard let tempIndex = tasks.index(of: temp) else { return }
                myViewContext.delete(temp)
                let myIndexPath = IndexPath(row: tempIndex, section: 0)
                tasks.remove(at: tempIndex)
                tableView.deleteRows(at: [myIndexPath], with: .fade)
                
                do {
                    try myViewContext.save()
                } catch let savingDeleteAllToCoreData {
                    print("Unable to save delete all changes to core data \(savingDeleteAllToCoreData)")
                }
                
            }
        } catch let deleteAllTasksErr {
            print("Unable to delete all tasks \(deleteAllTasksErr)")
        }
        
    }
    
    @objc private func handleLeftBarButton2(){
        tasks.sort()
    }
    
    @objc private func handleLeftBarButton3(){
        tableView.reloadData()
    }
    
    @objc private func handleRightBarButton(){
        //Add/Save
        print("right button pressed")
        let newVC = CreateTaskViewController()
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    func getIndexofIncomingTask(newTask: TaskItem, isSorted: Bool = true) -> Int {
        //assuming Tasks is already sorted
        //Unable to make this 'Private'  ... need to resolve this issue
        for (index, currentTask) in tasks.enumerated() {
            if newTask < currentTask { return index - 1}
        }
        return (tasks.count - 1)  //count = maxIndex + 1
    }
    
    
    //MARK:- Swift UI functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        
        setupNavigationBar()
        
        //var tasks = [TaskItem]()
        let myViewContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskItem>(entityName: "TaskItem")
        do {
            tasks = try myViewContext.fetch(fetchRequest)
            tasks.sort()
        } catch let fetchErr {
            fatalError("Unable to load task data from ViewDidLoad.fetchRequest  \(fetchErr)")
        }
        self.tableView.register(TasksListTableViewCell.self, forCellReuseIdentifier: taskTableID)
        view.backgroundColor = UIColor.yellow
        
        
        
        
    }
}

