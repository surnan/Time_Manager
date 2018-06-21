//
//  Helpers.swift
//  Time_Manager
//
//  Created by admin on 5/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

let taskTableID = "taskTableID"  //Registers table in TasksListViewUITableView.viewdidload()
let componentTableID = "componentTableID"  //Registers table in ComponentsListViewUITableView.viewdidload()


func printCoreDataPath(){
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    print(urls[urls.count-1] as URL)
}

//func convertToBinaryData(image: UIImage) -> (Any, Error) {
//    let tempData = UIImageJPEGRepresentation(image, 1)
//    return (tempData, nil)
//}

func isValidUrl(url: String) -> Bool {
    let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
    let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
    let result = urlTest.evaluate(with: url)
    return result
}
