//
//  TasklistViewController+UITableView.swift
//  Time_Manager
//
//  Created by admin on 5/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

//var tasks = ["Apple", "Banana", "Peach", "Strawberry", "Pineapple"]


extension TasksListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentTableViewCell = tableView.dequeueReusableCell(withIdentifier: taskTableID) as! TasksListTableViewCell
        let tempTask = tasks[indexPath.row]
        currentTableViewCell.nameLabel.text = tempTask
        return currentTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print(tasks[indexPath.row])
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete"){print("**** \(self.tasks[$1.row])")}
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: handlerEditAction)
        editAction.backgroundColor = UIColor.oliveGreen
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction, editAction]
    }

    private func handlerEditAction(action: UITableViewRowAction, indexPath: IndexPath) {
        print("edit")
    }
    
    
    
    
}
