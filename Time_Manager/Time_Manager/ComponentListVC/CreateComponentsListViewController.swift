//
//  CreateComponentsListViewController.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit



class CreateComponentsListViewController: UIViewController {
    var delegate: ComponentsListViewController?
    
    
    
    //MARK:- UI Functions
    private func setupNavBar(){
        navigationItem.title = "Create Component VC"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleRightBarButton))
        
    }
    
    @objc private func handleLeftBarButton(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func handleRightBarButton(){
        print("Handle Right")
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = UIColor.green
    }
}




