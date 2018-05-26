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
}
