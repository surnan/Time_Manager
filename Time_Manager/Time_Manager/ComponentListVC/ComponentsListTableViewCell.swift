//
//  ComponentsListTableViewCell.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class ComponentsListTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel = {
       var tempLabel = UILabel()
        return tempLabel
    }()
    
    var completionLabel: UILabel = {
        var tempLabel = UILabel()
        return tempLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [nameLabel, completionLabel].forEach{addSubview($0)}
        [nameLabel, completionLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}

        
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        completionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        completionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
