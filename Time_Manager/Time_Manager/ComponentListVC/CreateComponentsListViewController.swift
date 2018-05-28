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
    
    var nameLabel: UILabel = {
       let tempLabel = UILabel()
        tempLabel.text = "Name: "
        tempLabel.font = UIFont.boldSystemFont(ofSize: 25)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var nameTextField: UITextField = {
        let tempTextField = UITextField()
//        tempTextField.backgroundColor = UIColor.white
//        tempTextField.textAlignment = .center
        tempTextField.clearsOnBeginEditing = true
      tempTextField.placeholder = "Please enter name here"
//        tempTextField.text = " "  //work-around to have cursor begin in middle of nameTextField
        tempTextField.translatesAutoresizingMaskIntoConstraints = false
        return tempTextField
    }()
    
    
    //MARK:- UI Functions
    //MARK: Navigation Bar
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
    
    //MARK: Setting up Fields for User Entry
    private func setupUserFieldsforDataEntry(){
        [nameLabel, nameTextField].forEach{view.addSubview($0)}
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 20).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    

    
    
    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUserFieldsforDataEntry()
        view.backgroundColor = UIColor.lightBlue
    }
}




