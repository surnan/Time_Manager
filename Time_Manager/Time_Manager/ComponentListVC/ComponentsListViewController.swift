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
        print("addNewComponentToTableView was called")
        components.append(myComponentItem)
        let myIndexPath = IndexPath(row: components.count - 1, section: 0)
        tableView.insertRows(at: [myIndexPath], with: .left)
    }
    
    func editExistingComponentOnTableView(myComponentItem: ComponentItem) {
        print("editExistingComponentOnTableView was called")
    }
    
//    var components = ["Alphie", "Animal", "Panda Man", "Kermit"]
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .done, target: self, action: #selector(handleRightBarButton))
    }
    
    @objc private func handleLeftBarButton(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleRightBarButton(){
        print("Handle Right")
        let newVC = CreateComponentsListViewController()
        newVC.parentTask = currentTask
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        let myViewContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ComponentItem>(entityName: "ComponentItem")
        do {
        components = try myViewContext.fetch(fetchRequest)
//            components.forEach{print("componentsArray =   \($0.name ?? "")")}
        } catch let fetchingComponentsErr {
            print("Error fetching \(currentTask?.name ?? "") components: \(fetchingComponentsErr)")
        }
        tableView.register(ComponentsListTableViewCell.self, forCellReuseIdentifier: componentTableID)
        view.backgroundColor = UIColor.lightBlue
    }
}

