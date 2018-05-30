//
//  CoreDataManager.swift
//  Time_Manager
//
//  Created by admin on 5/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData


struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let myContainer = NSPersistentContainer(name: "CoreDataFile")
        myContainer.loadPersistentStores { (store, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        let context = myContainer.viewContext //do we need this line??
        return myContainer
    }()
}
