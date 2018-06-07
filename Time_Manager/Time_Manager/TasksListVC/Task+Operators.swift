//
//  Task+Operators.swift
//  Time_Manager
//
//  Created by admin on 6/6/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

extension TaskItem: Comparable {
    
    public static func < (lhs: TaskItem, rhs: TaskItem) -> Bool {
//        if let lhsDate = lhs.timeDate , let rhsDate = rhs.timeDate {
//            return (lhsDate < rhsDate)
//        } else {
//            return false
//        }
        
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "HH:mm"
        let lhsString = myDateFormatter.string(from: lhs.timeDate!)
        let rhsString = myDateFormatter.string(from: rhs.timeDate!)
        
        
        return lhsString < rhsString
        
    }
}
