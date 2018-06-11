//
//  ComponentDetailsViewController.swift
//  Time_Manager
//
//  Created by admin on 6/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import AVFoundation

class ComponentDetailsViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- Variable Def
    var textHeightConstraint: NSLayoutConstraint!
    var tapGestureComponentImage: UITapGestureRecognizer!
    var myImagePicker : UIImagePickerController = {
        let temp = UIImagePickerController()
        temp.allowsEditing = false
        temp.sourceType = .photoLibrary
        temp.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        return temp
    }()
    
    lazy var componentPicture : UIImageView = {
        let tempImage = UIImageView()
        tempImage.image = #imageLiteral(resourceName: "select_photo_empty")  //from assets
        tempImage.translatesAutoresizingMaskIntoConstraints = false
        tempImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        tempImage.contentMode = .scaleAspectFit
        tempImage.isUserInteractionEnabled = true
        tempImage.addGestureRecognizer(tapGestureComponentImage)
        

        
        return tempImage
    }()
    
    var componentText : UITextView = {
        let tempText = UITextView()
        tempText.text = "Hello World"
        tempText.sizeToFit()
        tempText.textAlignment = .center
        tempText.textColor = UIColor.white
        tempText.backgroundColor = UIColor.darkBlue
        tempText.isScrollEnabled = false
        tempText.translatesAutoresizingMaskIntoConstraints = false
        tempText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return tempText
    }()
    
    //MARK:- TextView Functions
    func textViewDidChange(_ textView: UITextView) {
        self.adjustTextViewHeight()
    }
    
    func adjustTextViewHeight() {
        let fixedWidth = componentText.frame.size.width
        let newSize = componentText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        if newSize.height > 200 {
            componentText.isScrollEnabled = true
        } else {
            componentText.isScrollEnabled = false
            self.textHeightConstraint.constant = newSize.height
        }
        self.view.layoutIfNeeded()
        //        self.view.layoutSubviews()  // also recommended as solution
    }
    
    
    //MARK:- UI Functions
    private func setupUI(){
        view.backgroundColor = UIColor.white
        setupNavBar()
        
        
        tapGestureComponentImage = UITapGestureRecognizer(target: self, action: #selector(handleTapComponentImage))
        
        
    }
    
    private func setupNavBar(){
        navigationItem.title = "ComponentDetails VC"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleLeftBarButton))
    }
    
    @objc private func handleLeftBarButton(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- UIImagePickerStuff
    
    @objc private func handleTapComponentImage(){
        print("Tapping Component Image")
        present(myImagePicker, animated: true)
    }
    
    
   func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        print("START PICKIN IMAGE .....")
        componentPicture.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        print("FINISH PICKIN IMAGE .....")
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    
    
    //MARK:- Swift Built In Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        componentText.delegate = self
        myImagePicker.delegate = self
        setupUI()
        
        textHeightConstraint = componentText.heightAnchor.constraint(equalToConstant: 40)   //variable defined earlier
        textHeightConstraint.isActive = true
        
        [componentPicture, componentText].forEach{view.addSubview($0)}
        componentPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        componentPicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10 ).isActive = true
        componentText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        componentText.topAnchor.constraint(equalTo: componentPicture.bottomAnchor, constant: 50).isActive = true
    }
}
