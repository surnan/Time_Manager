//
//  CreateComponentViewController.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

//MARK:- manipulatingComponentsListViewController Protocol defined
protocol manipulatingComponentsListViewController {
    func addNewComponentToTableView(myComponentItem: ComponentItem)
    func editExistingComponentOnTableView(myComponentItem: ComponentItem)
}



class CreateComponentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- Parameters passed in
    var delegate: manipulatingComponentsListViewController? //passed-in
    var parentTask: TaskItem?   //passed-in
    var currentComponentItem: ComponentItem? {  //passed-in
        didSet {
            nameTextField.text = currentComponentItem?.cName
           
            
//             if let tempImage = UIImage(data: (currentComponentItem?.cMedia)!)
            
            if let tempImage = currentComponentItem?.cMedia {
                iconImage.image =  UIImage(data: tempImage)
            }
        }
    }

    //MARK:- Locally Declared Variables (except PickerController)
    lazy var iconImage : UIImageView = {
        let tempImage = UIImageView()
        tempImage.image = #imageLiteral(resourceName: "select_photo_empty")
        tempImage.isUserInteractionEnabled = true
        tempImage.translatesAutoresizingMaskIntoConstraints = false
        tempImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        tempImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return tempImage
    }()
    
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
        //        tempTextField.text = " "  //work-around to have cursor begin in middle of nameTextField
        tempTextField.clearsOnBeginEditing = true
        tempTextField.placeholder = "Please enter name here"
        tempTextField.translatesAutoresizingMaskIntoConstraints = false
        return tempTextField
    }()
    
    
    //MARK:- UIPickerController
    var myImagePickerController: UIImagePickerController = {
        let tempPicker = UIImagePickerController()
        tempPicker.sourceType = .photoLibrary
        tempPicker.allowsEditing = true
        if let allMedia = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
            tempPicker.mediaTypes = allMedia
        }
        return tempPicker
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        iconImage.image = info[UIImagePickerControllerEditedImage] != nil ? info[UIImagePickerControllerEditedImage] as? UIImage :
            info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- UI Functions

    @objc private func handleIconTap(){
        print("Picture Clicked!!!")
        present(myImagePickerController, animated: true)
    }
    
    
    //MARK: Navigation Bar
    private func setupNavBar(){
        navigationItem.title = currentComponentItem != nil ? "Editing \(currentComponentItem?.cName ?? "stuff") " : "New Component"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleRightBarButton))
    }
    
    @objc private func handleLeftBarButton(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleRightBarButton(){
        print("Handle Right")
        if currentComponentItem == nil {
            let myContext = CoreDataManager.shared.persistentContainer.viewContext
            let tempObject = NSEntityDescription.insertNewObject(forEntityName: "ComponentItem", into: myContext) as! ComponentItem
            tempObject.setValue(parentTask, forKey: "linkTask")
            tempObject.setValue(nameTextField.text, forKey: "cName")
            if let imageData =  UIImageJPEGRepresentation(iconImage.image!, 1){
                tempObject.setValue(imageData, forKey: "cMedia")
            }
//            tempObject.setValue(nameTextField.text, forKey: "cWebsite")
//            tempObject.setValue(nameTextField.text, forKey: "video")
            
            do {
                try myContext.save()
                delegate?.addNewComponentToTableView(myComponentItem: tempObject)
            } catch let unableAddComponentErr {
                print("Unable to save Component \(unableAddComponentErr)")
            }
        } else {
            let myContext = CoreDataManager.shared.persistentContainer.viewContext
            currentComponentItem?.cName = nameTextField.text
            
            if let imageData =  UIImageJPEGRepresentation(iconImage.image!, 1){
                currentComponentItem?.cMedia = imageData
            }

            
            do {
                try myContext.save()
                delegate?.editExistingComponentOnTableView(myComponentItem: currentComponentItem!)
            } catch let unableAddComponentErr {
                print("Unable to save Component \(unableAddComponentErr)")
            }
            //            tempObject.setValue(nameTextField.text, forKey: "cWebsite")
            //            tempObject.setValue(nameTextField.text, forKey: "video")
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Setting up Fields for User Entry
    private func setupUserFieldsforDataEntry(){
        [iconImage, nameLabel, nameTextField].forEach{view.addSubview($0)}
        
        iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        nameLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 50).isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 20).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
    var myTapGesture : UITapGestureRecognizer!

    private func setupGestures(){
        myTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleIconTap))
        iconImage.addGestureRecognizer(myTapGesture)
    }
    
    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        myImagePickerController.delegate = self
        setupNavBar()
        setupUserFieldsforDataEntry()
        view.backgroundColor = UIColor.lightBlue
        setupGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("parentTask = \(parentTask?.name ?? "*EMPTY*")")
    }
    
}




