//
//  CreateTaskViewController.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class CreateTaskViewController: UIViewController {
    
    
    var delegate: TasksListViewController?
    
    
    
    //MARK:- UI Functions
    private func setupNavBar(){
        navigationItem.title = "Create/Edit"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handlerLeft))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handlerRight))
        
    }
    
    @objc private func handlerLeft(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)

    }

    @objc private func handlerRight(){
        print("Handle Right")
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = UIColor.lightGray
    }
}
