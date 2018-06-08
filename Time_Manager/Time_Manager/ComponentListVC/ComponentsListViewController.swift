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
        navigationItem.leftBarButtonItems = [UIBarButtonItem(title: "Back  ", style: .plain, target: self, action: #selector(handleLeftBarButton)), UIBarButtonItem(title: "ALL", style: .plain, target: self, action: #selector(handleLeftBarButton2))]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: " -ALL-", style: .done, target: self, action: #selector(handleRightBarButton))
    }
    
    @objc private func handleLeftBarButton(){
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
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
 */
    
    @objc private func handleLeftBarButton2(){
        let myViewContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ComponentItem>(entityName: "ComponentItem")
        do {
            let tempArray = try myViewContext.fetch(fetchRequest)
            tempArray.forEach{print($0.cName ?? "")}
        } catch let fetchingComponentsErr {
            print("*** unable to load all 'ComponentItems'")
            print(fetchingComponentsErr)
        }
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

