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

