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
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var completionLabel: UILabel = {
        var tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var iconImage: UIImageView = {
        var tempImage = UIImageView()
        tempImage.translatesAutoresizingMaskIntoConstraints = false
        return tempImage
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [iconImage, nameLabel, completionLabel].forEach{addSubview($0)}
        
        iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 20).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        completionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        completionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
