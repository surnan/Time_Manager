//
//  UI+Extensions.swift
//  Time_Manager
//
//  Created by admin on 5/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

extension UILabel {
    func placeUnderneath(aboveLabel: UILabel, spacing: CGFloat){
        topAnchor.constraint(equalTo: aboveLabel.bottomAnchor, constant: spacing).isActive = true
        leftAnchor.constraint(equalTo: aboveLabel.leftAnchor).isActive = true
    }
    
    func placeLeftofSwitch(thatSwitch: UISwitch, spacing: CGFloat){
        rightAnchor.constraint(equalTo: thatSwitch.leftAnchor , constant: spacing).isActive = true
        topAnchor.constraint(equalTo: thatSwitch.topAnchor).isActive = true
        heightAnchor.constraint(equalTo: thatSwitch.heightAnchor).isActive = true
    }
}




extension UISwitch {
    func placeUnderneath(aboveSwitch: UISwitch, spacing: CGFloat){
        topAnchor.constraint(equalTo: aboveSwitch.bottomAnchor, constant: spacing).isActive = true
        leftAnchor.constraint(equalTo: aboveSwitch.leftAnchor).isActive = true
    }
}
