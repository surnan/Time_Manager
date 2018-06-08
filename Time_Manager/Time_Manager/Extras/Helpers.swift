//
//  Helpers.swift
//  Time_Manager
//
//  Created by admin on 5/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

let taskTableID = "taskTableID"  //Registers table in TasksListViewUITableView.viewdidload()
let componentTableID = "componentTableID"  //Registers table in ComponentsListViewUITableView.viewdidload()


func printCoreDataPath(){
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    print(urls[urls.count-1] as URL)
}
