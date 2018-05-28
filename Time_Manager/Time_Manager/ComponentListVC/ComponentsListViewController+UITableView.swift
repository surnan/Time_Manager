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


extension ComponentsListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = CreateComponentsListViewController()
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
    }


    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: handlerEditAction)
        let deleteAction = UITableViewRowAction(style: .normal, title: "Cancel", handler: handlerDeleteAction)
        editAction.backgroundColor = UIColor.blue
        deleteAction.backgroundColor = UIColor.red
        return[deleteAction, editAction]
    }
    
    
    private func handlerEditAction(tableView: UITableViewRowAction, indexPath: IndexPath){
        print("edit action chosen")
        let newVC = CreateComponentsListViewController()
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
    }

    private func handlerDeleteAction(tableView: UITableViewRowAction, indexPath: IndexPath){
        print("delete action chosen")
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = tableView.dequeueReusableCell(withIdentifier: componentTableID) as! ComponentsListTableViewCell
        tempCell.nameLabel.text = components[indexPath.row]
        tempCell.completionLabel.text = "Completion_Label"
        return tempCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
}


/*
 @objc private func handlerRight(){
 print("Handle Right")
 let newVC = CreateComponentsListViewController()
 newVC.delegate = self
 navigationController?.pushViewController(newVC, animated: true)
 }
*/
