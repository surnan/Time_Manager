//
//  CreateComponentViewController.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData
import WebKit

//MARK:- manipulatingComponentsListViewController Protocol defined
protocol manipulatingComponentsListViewController {
    func addNewComponentToTableView(myComponentItem: ComponentItem)
    func editExistingComponentOnTableView(myComponentItem: ComponentItem)
}



class CreateComponentViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextViewDelegate,
UITextFieldDelegate, WKUIDelegate {
    //MARK:- Parameters passed in
    var delegate: manipulatingComponentsListViewController? //passed-in
    var parentTask: TaskItem?   //passed-in
    var currentComponentItem: ComponentItem? {  //passed-in
        didSet {
            nameTextField.text = currentComponentItem?.cName
            if let tempImage = currentComponentItem?.cMedia {
                iconImage.image =  UIImage(data: tempImage)
            }
            if let tempText = currentComponentItem?.cNotes {
                noteTextField.text = tempText
            }
            if let tempURL = currentComponentItem?.cWebsite {
                urlTextField.text = tempURL
            }
        }
    }  //
    
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
    
    
    var noteLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "NOTES"  //try to underline it
        tempLabel.font = UIFont.boldSystemFont(ofSize: 25)
        tempLabel.attributedText = NSAttributedString(string: tempLabel.text!, attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    //MARK: TextView Starts here
    var noteTextField: UITextView = {
        let tempTextField = UITextView()
        tempTextField.text = "Please enter notes"
        tempTextField.backgroundColor = UIColor.white
        tempTextField.textColor = UIColor.black
        tempTextField.isScrollEnabled = false
        //        tempTextField.sizeToFit()  // what exactly is this line doing?  //works if commented out
        tempTextField.translatesAutoresizingMaskIntoConstraints = false
        return tempTextField
    }()
    
    var textHeightConstraint: NSLayoutConstraint!
    
    func textViewDidChangeSelection(_ textView: UITextView){
        
        if textView == noteTextField {
            let fixedWidth = noteTextField.frame.size.width
            let newSize = noteTextField.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            if newSize.height > 200 {
                //before getting here, you would have built up the height to 200 from hitting the "else" clause
                noteTextField.isScrollEnabled = true
                textHeightConstraint.constant = 200
            } else {
                noteTextField.isScrollEnabled = false
                self.textHeightConstraint.constant = newSize.height
            }
            self.view.layoutIfNeeded()
            //                self.view.layoutSubviews()  // also recommended as solution
        } else {
            
        }
    }
    
    //MARK: Web Browser Setup & UIButton()
    @objc func handlewebsiteButtonPressed(){
        if let myURLString = urlTextField.text {
            UIApplication.shared.open(NSURL(string:myURLString)! as URL)
        }
    }
    
    
    //MARK: Collecting URL
    var urlLabel: UILabel = {
        var tempLabel = UILabel()
        tempLabel.textColor = UIColor.black
        tempLabel.backgroundColor = UIColor.white
        tempLabel.text = "--TYPE/PASTE NEW URL BELOW--"
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var urlTextField: UITextField = {
        var tempTextField = UITextField()
        tempTextField.placeholder = "Paste or type in new URL"
        tempTextField.backgroundColor = UIColor.white
        tempTextField.textColor = UIColor.black
        tempTextField.clearsOnBeginEditing = true
        tempTextField.translatesAutoresizingMaskIntoConstraints = false
        return tempTextField
    }()
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let myBool = textField.text {
            if myBool.isEmpty {
                websiteButton.isHidden = true
            } else {
                websiteButton.isHidden = false
            }
        }
    }
    
    
    
    
    var websiteButton : UIButton = {
        let tempButton = UIButton()
        tempButton.setTitle("PRESS BUTTON TO LOAD WEBSITE", for: .normal)
        tempButton.setTitleColor(UIColor.yellow, for: .normal)
        tempButton.backgroundColor = UIColor.blue
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        tempButton.addTarget(self, action: #selector(handlewebsiteButtonPressed), for: .touchDown)
        return tempButton
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
            
            if let tempNotesText = noteTextField.text {
                tempObject.cNotes = tempNotesText
            }
            
            if let tempNotesText = noteTextField.text {
                tempObject.cNotes = tempNotesText
            }
            
            if let urlText = urlTextField.text {
                //verify that it's also a valid URL type also
                tempObject.cWebsite = urlText
            }
            //            tempObject.setValue(nameTextField.text, forKey: "video")
            //            tempObject.setValue(nameTextField.text, forKey: "cTextDetails")
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
            
            if let tempNotesText = noteTextField.text {
                currentComponentItem?.cNotes = tempNotesText
            }
            
            if let urlText = urlTextField.text {
                currentComponentItem?.cWebsite = urlText
            }
            
            
            do {
                try myContext.save()
                delegate?.editExistingComponentOnTableView(myComponentItem: currentComponentItem!)
            } catch let unableAddComponentErr {
                print("Unable to save Component \(unableAddComponentErr)")
            }
            //            tempObject.setValue(nameTextField.text, forKey: "cWebsite")
            //            tempObject.setValue(nameTextField.text, forKey: "video")
            //            tempObject.setValue(nameTextField.text, forKey: "cTextDetails")
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Setting up Fields for User Entry
    private func setupUserFieldsforDataEntry(){
        [websiteButton, noteTextField, noteLabel, iconImage, nameLabel, nameTextField, urlLabel, urlTextField].forEach{view.addSubview($0)}
        
        //Change nameLabel to shift left as NameTextField is being edited
        //Consider 'nameLabel+nameTextField' = UIStackView
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 20).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        noteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        noteTextField.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20).isActive = true
        noteTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        noteTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        //        noteTextField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true  //kills the variable height
        
        
        iconImage.topAnchor.constraint(equalTo: noteTextField.bottomAnchor, constant: 30).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        urlLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 30).isActive = true
        urlLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        urlTextField.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 10).isActive = true
        urlTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        urlTextField.leftAnchor.constraint(equalTo: noteTextField.leftAnchor).isActive = true
        urlTextField.rightAnchor.constraint(equalTo: noteTextField.rightAnchor).isActive = true
        
        websiteButton.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 20).isActive = true
        websiteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    //MARK:- Setup Gesture
    var myTapGesture : UITapGestureRecognizer!
    private func setupGestures(){
        myTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleIconTap))
        iconImage.addGestureRecognizer(myTapGesture)
    }
    
    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        myImagePickerController.delegate = self
        urlTextField.delegate = self
        noteTextField.delegate = self
        setupNavBar()
        textHeightConstraint = noteTextField.heightAnchor.constraint(equalToConstant: 40)   //variable defined earlier
        
        
        textHeightConstraint.isActive = true
        setupUserFieldsforDataEntry()
        view.backgroundColor = UIColor.lightBlue
        setupGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("parentTask = \(parentTask?.name ?? "*EMPTY*")")
    }
}




