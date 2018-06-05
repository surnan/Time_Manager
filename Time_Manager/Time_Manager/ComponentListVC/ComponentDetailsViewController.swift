//
//  ComponentDetailsViewController.swift
//  Time_Manager
//
//  Created by admin on 6/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ComponentDetailsViewController: UIViewController {
    
    
    
    //MARK:- UI Functions
    private func setupNavBar(){
        navigationItem.title = "ComponentDetails VC"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleLeftBarButton))
    }
    
    @objc private func handleLeftBarButton(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK:- Swift Built In Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = UIColor.lightGray
    }
}
