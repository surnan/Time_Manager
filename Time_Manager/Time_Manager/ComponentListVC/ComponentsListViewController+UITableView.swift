//
//  ComponentsListViewController+UITableView.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

//
//var delegate: TasksListViewController?
//
//var components = ["Alphie", "Animal", "Panda Man", "Kermit"]




extension ComponentsListViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = ComponentDetailsViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: handlerEditAction)
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: handlerDeleteAction)
        editAction.backgroundColor = UIColor.blue
        deleteAction.backgroundColor = UIColor.red
        return[deleteAction, editAction]
    }

    private func handlerEditAction(tableView: UITableViewRowAction, indexPath: IndexPath){
        let newVC = CreateComponentsListViewController()
         newVC.currentComponentItem = components[indexPath.row]
        newVC.parentTask = currentTask
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
    }

    private func handlerDeleteAction(tableView: UITableViewRowAction, indexPath: IndexPath){
        let tempComponent = components[indexPath.row]
        let myContext = CoreDataManager.shared.persistentContainer.viewContext
        myContext.delete(tempComponent)
        do {
            try myContext.save()
        } catch let componentDeleteErr {
            print("Unable to delete component \(componentDeleteErr)")
        }
        let tempComponentIndex = components.index(of: tempComponent)
        components.remove(at: tempComponentIndex!)
        self.tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = tableView.dequeueReusableCell(withIdentifier: componentTableID) as! ComponentsListTableViewCell
        tempCell.nameLabel.text = "\(components[indexPath.row].cName ?? "*EMPTY*")"
        tempCell.completionLabel.text = "Completion_Label"
        return tempCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
}
