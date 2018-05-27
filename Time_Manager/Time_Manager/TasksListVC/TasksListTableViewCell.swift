//
//  TasksListTableViewCell.swift
//  Time_Manager
//
//  Created by admin on 5/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class TasksListTableViewCell: UITableViewCell {
    
    var nameLabel:UILabel = {
        let tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "Name.init"
        return tempLabel
    }()
    
    var timeLabel: UILabel = {
       let tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "time.init"
        return tempLabel
    }()
    
    var completionLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "completion.init"
        return tempLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [nameLabel, timeLabel, completionLabel].forEach{addSubview($0)}
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        completionLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 55).isActive = true
        completionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
