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
        currentTableViewCell.nameLabel.text = tempTask.name
        currentTableViewCell.timeLabel.text = "Now"
        currentTableViewCell.completionLabel.text = "True"
        return currentTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(tasks[indexPath.row])
        let newVC = ComponentsListViewController()
        newVC.delegate = self
        newVC.currentTask = tasks[indexPath.row]
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete"){print("**** \(self.tasks[$1.row])")}
       
         let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: handlerDeleteAction)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: handlerEditAction)
        editAction.backgroundColor = UIColor.oliveGreen
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction, editAction]
    }
    
    private func handlerDeleteAction(action: UITableViewRowAction, indexPath: IndexPath) {
        let currentTask = tasks[indexPath.row]
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(currentTask)
        do {
            try context.save()
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } catch let delError {
            print("Unable to delete task \(delError)")
        }
    }
    
    
    private func handlerEditAction(action: UITableViewRowAction, indexPath: IndexPath) {
        print("edit")
        let newVC = CreateTaskViewController()
        newVC.delegate = self
        newVC.currentTaskItem = tasks[indexPath.row]
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Completed", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, marked as Completed")
            success(true)
        })
        closeAction.backgroundColor = .purple
        print("Closing --> \(tasks[indexPath.row])")
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
}


/*
 func tableView(_ tableView: UITableView,
 leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
 {
 let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
 print("OK, marked as Closed")
 success(true)
 })
 closeAction.image = UIImage(named: "tick")
 closeAction.backgroundColor = .purple
 
 return UISwipeActionsConfiguration(actions: [closeAction])
 
 }
 
 func tableView(_ tableView: UITableView,
 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
 {
 let modifyAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
 print("Update action ...")
 success(true)
 })
 modifyAction.image = UIImage(named: "hammer")
 modifyAction.backgroundColor = .blue
 
 return UISwipeActionsConfiguration(actions: [modifyAction])
 }
 */

